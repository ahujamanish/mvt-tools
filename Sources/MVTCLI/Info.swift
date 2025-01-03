import ArgumentParser
import Foundation
import MVTTools

extension CLI {

    struct Info: AsyncParsableCommand {

        static let configuration = CommandConfiguration(
            abstract: "Print information about the input file (MVT or GeoJSON)",
            discussion: """
            Available tables:
            - features: Feature counts (points, linestrings, polygons) for each layer
                        in the input file.
            - properties: Counts of all Feature properties for each layer in the
                          input file.
            - property=<property>: Count the values for '<property>' across all layers
                                   and features  (can be repeated). Note: This doesn't
                                   work for Array and Dictionary values.
            """)

        @Option(
            name: .shortAndLong,
            help: "The tables to print, comma separated list of '\(InfoTables.allCases.map(\.rawValue).joined(separator: ","))'.",
            transform: InfoTables.parse)
        var infoTables: [InfoTables] = [.features, .properties]

        @Option(
            name: .shortAndLong,
            help: "Shortcut for -i property=<property> (can be repeated).")
        var property: [String] = []

        @OptionGroup
        var options: Options

        @Argument(
            help: "The vector tile or GeoJSON (file or URL).",
            completion: .file(extensions: ["pbf", "mvt", "geojson", "json"]))
        var path: String

        mutating func run() async throws {
            let url = try options.parseUrl(fromPath: path)

            guard var layers = VectorTile.tileInfo(at: url)
                    ?? VectorTile(contentsOfGeoJson: url, layerProperty: nil)?.tileInfo()
            else { throw CLIError("Error retreiving the tile info for '\(path)'") }

            if options.verbose {
                print("Info for tile '\(url.lastPathComponent)'")
            }

            if property.isNotEmpty {
                infoTables = [.property(property.uniqued)]
            }

            layers.sort { first, second in
                first.name.compare(second.name) == .orderedAscending
            }

            for (index, table) in infoTables.enumerated() {
                switch table {
                case .features:
                    dumpFeatures(layers)
                case .properties:
                    dumpProperties(layers)
                case let .property(names):
                    dumpProperty(layers, names: names)
                }

                if index < infoTables.count - 1 {
                    print()
                }
            }

            if options.verbose {
                print("Done.")
            }
        }

        private func dumpFeatures(_ layers: [VectorTile.LayerInfo]) {
            let tableHeader = ["Name", "Features", "Points", "LineStrings", "Polygons", "Unknown", "Version"]
            let table: [[String]] = [
                layers.compactMap({ $0.name }),
                layers.compactMap({ $0.features.toString }),
                layers.compactMap({ $0.pointFeatures.toString }),
                layers.compactMap({ $0.linestringFeatures.toString }),
                layers.compactMap({ $0.polygonFeatures.toString }),
                layers.compactMap({ $0.unknownFeatures.toString }),
                layers.compactMap({ $0.version?.toString }),
            ]

            let result = dumpSideBySide(
                table,
                asTableWithHeaders: tableHeader)

            print(result)
        }

        private func dumpProperties(_ layers: [VectorTile.LayerInfo]) {
            var tableHeader = ["Name"]

            let propertyNames: [String] = layers
                .flatMap({ $0.propertyNames.keys })
                .uniqued
                .sorted(by: <)

            tableHeader.append(contentsOf: propertyNames)

            var table: [[String]] = []
            table.append(layers.map({ $0.name }))

            for propertyName in propertyNames {
                var column: [String] = []
                for layer in layers {
                    let propertyNames = layer.propertyNames
                    column.append((propertyNames[propertyName] ?? 0).toString)
                }
                table.append(column)
            }

            let result = dumpSideBySide(
                table,
                asTableWithHeaders: tableHeader)

            print(result)
        }

        func dumpProperty(_ layers: [VectorTile.LayerInfo], names: [String]) {
            let propertyValues: [String: [String: Int]] = layers.reduce(into: [:]) { result, layer in
                for name in names {
                    guard let values = layer.propertyValues[name] else { continue }

                    var thisNameValues = result[name] ?? [:]
                    thisNameValues.merge(values) { $0 + $1 }
                    result[name] = thisNameValues
                }
            }
            let propertyNames = propertyValues.flatMap({ $1.keys }).sorted()

            var tableHeader = ["Name"]
            tableHeader.append(contentsOf: propertyNames)

            var table: [[String]] = []
            table.append(names)

            for propertyName in propertyNames {
                var column: [String] = []
                for name in names {
                    column.append((propertyValues[name]?[propertyName] ?? 0).toString)
                }
                table.append(column)
            }

            let result = dumpSideBySide(
                table,
                asTableWithHeaders: tableHeader)

            print(result)
        }

        private func dumpSideBySide(
            _ strings: [[String]],
            asTableWithHeaders headers: [String])
            -> String
        {
            var result: [String] = []

            // Setup

            let columns: Int = strings.count
            let rows: Int = strings.reduce(0) { (result, array) in
                (array.count > result ? array.count : result)
            }

            var columnWidths: [Int] = strings.map { $0.reduce(0, { max($0, $1.count) }) }

            guard headers.count == strings.count else {
                print("headers and strings don't match")
                return ""
            }

            for (index, header) in headers.enumerated() {
                columnWidths[index] = max(columnWidths[index], header.count)
            }

            // Assembling the table

            var headerColumns: [String] = []
            var headerSeparators: [String] = []

            for column in 0 ..< columns {
                let string = headers.get(at: column) ?? ""
                let columnWidth = columnWidths[column]

                headerColumns.append((column == 0 ? " " : "") + string.padding(toLength: columnWidth, withPad: " ", startingAt: 0))
                headerSeparators.append((column == 0 ? "-" : "") + String(repeating: "-", count: columnWidths[column]))
            }

            result.append(headerColumns.joined(separator: " | "))
            result.append(headerSeparators.joined(separator: "-+-"))

            for row in 0 ..< rows {
                var currentColumns: [String] = []

                for column in 0 ..< columns {
                    let string = strings[column].get(at: row) ?? ""
                    currentColumns.append((column == 0 ? " " : "") + string.padding(toLength: columnWidths[column], withPad: " ", startingAt: 0))
                }

                result.append(currentColumns.joined(separator: " | "))
            }

            return result.joined(separator: "\n")
        }

    }

    // MARK: - InfoTables

    enum InfoTables: CaseIterable {
        case features
        case properties
        case property([String])

        static var allCases: [InfoTables] {
            [.features, .properties, .property([])]
        }

        @Sendable
        static func parse(_ rawValue: String) -> [InfoTables] {
            var result: [InfoTables] = []
            var properties: Set<String> = []

            let components = rawValue.components(separatedBy: ",")
            for component in components {
                if component == "features" {
                    result.append(.features)
                    continue
                }
                if component == "properties" {
                    result.append(.properties)
                    continue
                }

                let propertyParts = component.components(separatedBy: "=")
                guard propertyParts.count == 2,
                      propertyParts[0] == "property"
                else { continue }

                properties.insert(propertyParts[1])
            }

            if properties.isNotEmpty {
                result.append(.property(properties.sorted()))
            }

            return result
        }

        var rawValue: String {
            switch self {
            case .features: "features"
            case .properties: "properties"
            case .property: "property"
            }
        }
    }

}
