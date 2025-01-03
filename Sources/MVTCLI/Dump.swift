import ArgumentParser
import Foundation
import MVTTools

extension CLI {

    struct Dump: AsyncParsableCommand {

        static let configuration = CommandConfiguration(
            abstract: "Print the input file (MVT or GeoJSON) as pretty-printed GeoJSON to the console")

        @Option(
            name: .shortAndLong,
            help: "Dump the specified layer (can be repeated).")
        var layer: [String] = []

        @Option(
            name: .shortAndLong,
            help: "Drop the specified layer (can be repeated).")
        var dropLayer: [String] = []

        @Option(
            name: [.customShort("P"), .long],
            help: "Feature property to use for the layer name in input and output GeoJSONs. Needed for filtering by layer.")
        var propertyName: String = VectorTile.defaultLayerPropertyName

        @Flag(
            name: [.customLong("Di", withSingleDash: true), .long],
            help: "Don't parse the layer name (option 'property-name') from Feature properties in the input GeoJSONs. Might speed up GeoJSON parsing considerably.")
        var disableInputLayerProperty = false

        @Flag(
            name: [.customLong("Do", withSingleDash: true), .long],
            help: "Don't add the layer name (option 'property-name') as a Feature property in the output GeoJSONs.")
        var disableOutputLayerProperty = false

        @Option(
            name: [.customLong("oSm", withSingleDash: true), .long],
            help: "Simplify output features using meters.")
        var simplifyMeters: Int?

        @OptionGroup
        var xyzOptions: XYZOptions

        @OptionGroup
        var options: Options

        @Argument(
            help: "The vector tile or GeoJSON (file or URL).",
            completion: .file(extensions: ["pbf", "mvt", "geojson", "json"]))
        var path: String

        mutating func run() async throws {
            let url = try options.parseUrl(fromPath: path)
            let layerAllowlist = layer.asSet.subtracting(dropLayer).asArray.nonempty
            let layerDenylist = dropLayer.asSet.subtracting(layer).asArray.nonempty

            var tile = VectorTile(
                contentsOfGeoJson: url,
                layerProperty: disableInputLayerProperty ? nil : propertyName,
                layerWhitelist: disableInputLayerProperty ? nil : layerAllowlist,
                logger: options.verbose ? CLI.logger : nil)

            if tile == nil,
               let (x, y, z) = try? xyzOptions.parseXYZ(fromPaths: [path])
            {
                tile = VectorTile(
                    contentsOf: url,
                    x: x,
                    y: y,
                    z: z,
                    layerWhitelist: layerAllowlist,
                    logger: options.verbose ? CLI.logger : nil)
            }

            guard let tile else { throw CLIError("Failed to parse the resource at '\(path)'") }

            if tile.origin == .geoJson,
               disableInputLayerProperty
            {
                if let layerAllowlist,
                   layerAllowlist.isNotEmpty
                {
                    if options.verbose {
                        print("Warning: GeoJSON without layers, no filtering possible")
                    }
                    return
                }
            }

            var exportOptions = VectorTile.ExportOptions()
            if let simplifyMeters, simplifyMeters > 0 {
                exportOptions.simplifyFeatures = .meters(Double(simplifyMeters))
            }

            if options.verbose {
                print("Dumping \(tile.origin) tile '\(url.lastPathComponent)' [\(tile.x),\(tile.y)]@\(tile.z)")

                print("Layer property name: \(propertyName)")
                if disableInputLayerProperty {
                    print("  - disable input layer property")
                }
                if disableOutputLayerProperty {
                    print("  - disable output layer property")
                }

                if disableInputLayerProperty,
                   !disableOutputLayerProperty
                {
                    print("  - Warning: Default output layer names will be used with -Di")
                }

                if tile.origin == .mvt
                    || !disableInputLayerProperty
                {
                    if let layerAllowlist {
                        print("Allowed layers: '\(layerAllowlist.sorted().joined(separator: ","))'")
                    }
                    if let layerDenylist {
                        print("Dropped layers: '\(layerDenylist.sorted().joined(separator: ","))'")
                    }
                }

                print("Output options:")
                print("  - Pretty print: true")
                print("  - Simplification: \(exportOptions.simplifyFeatures)")

                print("GeoJSON:")
            }

            var layerNames: [String] = []
            if let layerDenylist {
                layerNames = tile.layerNames.asSet.subtracting(layerDenylist).asArray
            }

            guard let data = tile.toGeoJson(
                layerNames: layerNames,
                prettyPrinted: true,
                layerProperty: disableOutputLayerProperty ? nil : propertyName,
                options: exportOptions)
            else { throw CLIError("Failed to extract the tile data as GeoJSON") }

            print(String(data: data, encoding: .utf8) ?? "", terminator: "")
            print()

            if options.verbose {
                print("Done.")
            }
        }

    }

}
