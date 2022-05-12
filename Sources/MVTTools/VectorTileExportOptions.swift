#if !os(Linux)
import CoreLocation
#endif
import Foundation
import GISTools

/// Various export options.
public struct VectorTileExportOptions {

    /// Options for the buffer around tiles.
    public enum BufferSizeOptions {
        /// Use the same dimension as ``VectorTileExportOptions.extent``.
        case extent(Int)
        /// Use pixels (see ``VectorTileExportOptions.tileSize``).
        case pixel(Int)
    }

    /// Gzip options.
    public enum CompressionOptions: Equatable {
        /// Don't compress the vector tile data.
        case no
        /// The default compression level (*6*).
        case `default`
        /// A compression level, between *0* (no compression) and *9* (best compression).
        case level(Int)
    }

    /// Options for Feature simplification.
    public enum SimplifyFeaturesOptions {
        /// Don't simplify featutes.
        case no
        /// Use the same dimension as ``VectorTileExportOptions.extent``.
        case extent(Int)
        /// Use meters.
        case meters(CLLocationDistance)
    }

    /// The grid width and height of one tile. Always 4096.
    public let extent: Int = 4096

    /// The tile size in pixels. Always 256.
    public let tileSize: Int = 256

    /// The buffer around the tile, either in pixels (see ``tileSize``) or in the same dimension as ``extent`` (default: **0**).
    public var bufferSize: BufferSizeOptions = .extent(0)

    /// Whether to enable compression or not (default: **no**)
    ///
    /// Uses Gzip.
    public var compression: CompressionOptions = .no

    /// Simplify features before encoding them (default: **no**).
    public var simplifyFeatures: SimplifyFeaturesOptions = .no

}
