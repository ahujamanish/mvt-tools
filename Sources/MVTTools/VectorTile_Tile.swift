// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: proto/vector_tile.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct VectorTile_Tile: SwiftProtobuf.ExtensibleMessage, Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var layers: [VectorTile_Tile.Layer] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  /// GeomType is described in section 4.3.4 of the specification
  enum GeomType: SwiftProtobuf.Enum, Swift.CaseIterable {
    typealias RawValue = Int
    case unknown // = 0
    case point // = 1
    case linestring // = 2
    case polygon // = 3

    init() {
      self = .unknown
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .unknown
      case 1: self = .point
      case 2: self = .linestring
      case 3: self = .polygon
      default: return nil
      }
    }

    var rawValue: Int {
      switch self {
      case .unknown: return 0
      case .point: return 1
      case .linestring: return 2
      case .polygon: return 3
      }
    }

  }

  /// Variant type encoding
  /// The use of values is described in section 4.1 of the specification
  struct Value: SwiftProtobuf.ExtensibleMessage, Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// Exactly one of these values must be present in a valid message
    var stringValue: String {
      get {return _stringValue ?? String()}
      set {_stringValue = newValue}
    }
    /// Returns true if `stringValue` has been explicitly set.
    var hasStringValue: Bool {return self._stringValue != nil}
    /// Clears the value of `stringValue`. Subsequent reads from it will return its default value.
    mutating func clearStringValue() {self._stringValue = nil}

    var floatValue: Float {
      get {return _floatValue ?? 0}
      set {_floatValue = newValue}
    }
    /// Returns true if `floatValue` has been explicitly set.
    var hasFloatValue: Bool {return self._floatValue != nil}
    /// Clears the value of `floatValue`. Subsequent reads from it will return its default value.
    mutating func clearFloatValue() {self._floatValue = nil}

    var doubleValue: Double {
      get {return _doubleValue ?? 0}
      set {_doubleValue = newValue}
    }
    /// Returns true if `doubleValue` has been explicitly set.
    var hasDoubleValue: Bool {return self._doubleValue != nil}
    /// Clears the value of `doubleValue`. Subsequent reads from it will return its default value.
    mutating func clearDoubleValue() {self._doubleValue = nil}

    var intValue: Int64 {
      get {return _intValue ?? 0}
      set {_intValue = newValue}
    }
    /// Returns true if `intValue` has been explicitly set.
    var hasIntValue: Bool {return self._intValue != nil}
    /// Clears the value of `intValue`. Subsequent reads from it will return its default value.
    mutating func clearIntValue() {self._intValue = nil}

    var uintValue: UInt64 {
      get {return _uintValue ?? 0}
      set {_uintValue = newValue}
    }
    /// Returns true if `uintValue` has been explicitly set.
    var hasUintValue: Bool {return self._uintValue != nil}
    /// Clears the value of `uintValue`. Subsequent reads from it will return its default value.
    mutating func clearUintValue() {self._uintValue = nil}

    var sintValue: Int64 {
      get {return _sintValue ?? 0}
      set {_sintValue = newValue}
    }
    /// Returns true if `sintValue` has been explicitly set.
    var hasSintValue: Bool {return self._sintValue != nil}
    /// Clears the value of `sintValue`. Subsequent reads from it will return its default value.
    mutating func clearSintValue() {self._sintValue = nil}

    var boolValue: Bool {
      get {return _boolValue ?? false}
      set {_boolValue = newValue}
    }
    /// Returns true if `boolValue` has been explicitly set.
    var hasBoolValue: Bool {return self._boolValue != nil}
    /// Clears the value of `boolValue`. Subsequent reads from it will return its default value.
    mutating func clearBoolValue() {self._boolValue = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    var _protobuf_extensionFieldValues = SwiftProtobuf.ExtensionFieldValueSet()
    fileprivate var _stringValue: String? = nil
    fileprivate var _floatValue: Float? = nil
    fileprivate var _doubleValue: Double? = nil
    fileprivate var _intValue: Int64? = nil
    fileprivate var _uintValue: UInt64? = nil
    fileprivate var _sintValue: Int64? = nil
    fileprivate var _boolValue: Bool? = nil
  }

  /// Features are described in section 4.2 of the specification
  struct Feature: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var id: UInt64 {
      get {return _id ?? 0}
      set {_id = newValue}
    }
    /// Returns true if `id` has been explicitly set.
    var hasID: Bool {return self._id != nil}
    /// Clears the value of `id`. Subsequent reads from it will return its default value.
    mutating func clearID() {self._id = nil}

    /// Tags of this feature are encoded as repeated pairs of
    /// integers.
    /// A detailed description of tags is located in sections
    /// 4.2 and 4.4 of the specification
    var tags: [UInt32] = []

    /// The type of geometry stored in this feature.
    var type: VectorTile_Tile.GeomType {
      get {return _type ?? .unknown}
      set {_type = newValue}
    }
    /// Returns true if `type` has been explicitly set.
    var hasType: Bool {return self._type != nil}
    /// Clears the value of `type`. Subsequent reads from it will return its default value.
    mutating func clearType() {self._type = nil}

    /// Contains a stream of commands and parameters (vertices).
    /// A detailed description on geometry encoding is located in
    /// section 4.3 of the specification.
    var geometry: [UInt32] = []

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    fileprivate var _id: UInt64? = nil
    fileprivate var _type: VectorTile_Tile.GeomType? = nil
  }

  /// Layers are described in section 4.1 of the specification
  struct Layer: SwiftProtobuf.ExtensibleMessage, Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// Any compliant implementation must first read the version
    /// number encoded in this message and choose the correct
    /// implementation for this version number before proceeding to
    /// decode other parts of this message.
    var version: UInt32 {
      get {return _version ?? 1}
      set {_version = newValue}
    }
    /// Returns true if `version` has been explicitly set.
    var hasVersion: Bool {return self._version != nil}
    /// Clears the value of `version`. Subsequent reads from it will return its default value.
    mutating func clearVersion() {self._version = nil}

    var name: String {
      get {return _name ?? String()}
      set {_name = newValue}
    }
    /// Returns true if `name` has been explicitly set.
    var hasName: Bool {return self._name != nil}
    /// Clears the value of `name`. Subsequent reads from it will return its default value.
    mutating func clearName() {self._name = nil}

    /// The actual features in this tile.
    var features: [VectorTile_Tile.Feature] = []

    /// Dictionary encoding for keys
    var keys: [String] = []

    /// Dictionary encoding for values
    var values: [VectorTile_Tile.Value] = []

    /// Although this is an "optional" field it is required by the specification.
    /// See https://github.com/mapbox/vector-tile-spec/issues/47
    var extent: UInt32 {
      get {return _extent ?? 4096}
      set {_extent = newValue}
    }
    /// Returns true if `extent` has been explicitly set.
    var hasExtent: Bool {return self._extent != nil}
    /// Clears the value of `extent`. Subsequent reads from it will return its default value.
    mutating func clearExtent() {self._extent = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    var _protobuf_extensionFieldValues = SwiftProtobuf.ExtensionFieldValueSet()
    fileprivate var _version: UInt32? = nil
    fileprivate var _name: String? = nil
    fileprivate var _extent: UInt32? = nil
  }

  init() {}

  var _protobuf_extensionFieldValues = SwiftProtobuf.ExtensionFieldValueSet()
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "vector_tile"

extension VectorTile_Tile: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Tile"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    3: .same(proto: "layers"),
  ]

  public var isInitialized: Bool {
    if !_protobuf_extensionFieldValues.isInitialized {return false}
    if !SwiftProtobuf.Internal.areAllInitialized(self.layers) {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.layers) }()
      case 16..<8192:
        try { try decoder.decodeExtensionField(values: &_protobuf_extensionFieldValues, messageType: VectorTile_Tile.self, fieldNumber: fieldNumber) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.layers.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.layers, fieldNumber: 3)
    }
    try visitor.visitExtensionFields(fields: _protobuf_extensionFieldValues, start: 16, end: 8192)
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: VectorTile_Tile, rhs: VectorTile_Tile) -> Bool {
    if lhs.layers != rhs.layers {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    if lhs._protobuf_extensionFieldValues != rhs._protobuf_extensionFieldValues {return false}
    return true
  }
}

extension VectorTile_Tile.GeomType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNKNOWN"),
    1: .same(proto: "POINT"),
    2: .same(proto: "LINESTRING"),
    3: .same(proto: "POLYGON"),
  ]
}

extension VectorTile_Tile.Value: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = VectorTile_Tile.protoMessageName + ".Value"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "string_value"),
    2: .standard(proto: "float_value"),
    3: .standard(proto: "double_value"),
    4: .standard(proto: "int_value"),
    5: .standard(proto: "uint_value"),
    6: .standard(proto: "sint_value"),
    7: .standard(proto: "bool_value"),
  ]

  public var isInitialized: Bool {
    if !_protobuf_extensionFieldValues.isInitialized {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._stringValue) }()
      case 2: try { try decoder.decodeSingularFloatField(value: &self._floatValue) }()
      case 3: try { try decoder.decodeSingularDoubleField(value: &self._doubleValue) }()
      case 4: try { try decoder.decodeSingularInt64Field(value: &self._intValue) }()
      case 5: try { try decoder.decodeSingularUInt64Field(value: &self._uintValue) }()
      case 6: try { try decoder.decodeSingularSInt64Field(value: &self._sintValue) }()
      case 7: try { try decoder.decodeSingularBoolField(value: &self._boolValue) }()
      case 8..<536870912:
        try { try decoder.decodeExtensionField(values: &_protobuf_extensionFieldValues, messageType: VectorTile_Tile.Value.self, fieldNumber: fieldNumber) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._stringValue {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._floatValue {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._doubleValue {
      try visitor.visitSingularDoubleField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._intValue {
      try visitor.visitSingularInt64Field(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._uintValue {
      try visitor.visitSingularUInt64Field(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._sintValue {
      try visitor.visitSingularSInt64Field(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._boolValue {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 7)
    } }()
    try visitor.visitExtensionFields(fields: _protobuf_extensionFieldValues, start: 8, end: 536870912)
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: VectorTile_Tile.Value, rhs: VectorTile_Tile.Value) -> Bool {
    if lhs._stringValue != rhs._stringValue {return false}
    if lhs._floatValue != rhs._floatValue {return false}
    if lhs._doubleValue != rhs._doubleValue {return false}
    if lhs._intValue != rhs._intValue {return false}
    if lhs._uintValue != rhs._uintValue {return false}
    if lhs._sintValue != rhs._sintValue {return false}
    if lhs._boolValue != rhs._boolValue {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    if lhs._protobuf_extensionFieldValues != rhs._protobuf_extensionFieldValues {return false}
    return true
  }
}

extension VectorTile_Tile.Feature: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = VectorTile_Tile.protoMessageName + ".Feature"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "tags"),
    3: .same(proto: "type"),
    4: .same(proto: "geometry"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self._id) }()
      case 2: try { try decoder.decodeRepeatedUInt32Field(value: &self.tags) }()
      case 3: try { try decoder.decodeSingularEnumField(value: &self._type) }()
      case 4: try { try decoder.decodeRepeatedUInt32Field(value: &self.geometry) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._id {
      try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
    } }()
    if !self.tags.isEmpty {
      try visitor.visitPackedUInt32Field(value: self.tags, fieldNumber: 2)
    }
    try { if let v = self._type {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 3)
    } }()
    if !self.geometry.isEmpty {
      try visitor.visitPackedUInt32Field(value: self.geometry, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: VectorTile_Tile.Feature, rhs: VectorTile_Tile.Feature) -> Bool {
    if lhs._id != rhs._id {return false}
    if lhs.tags != rhs.tags {return false}
    if lhs._type != rhs._type {return false}
    if lhs.geometry != rhs.geometry {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension VectorTile_Tile.Layer: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = VectorTile_Tile.protoMessageName + ".Layer"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    15: .same(proto: "version"),
    1: .same(proto: "name"),
    2: .same(proto: "features"),
    3: .same(proto: "keys"),
    4: .same(proto: "values"),
    5: .same(proto: "extent"),
  ]

  public var isInitialized: Bool {
    if !_protobuf_extensionFieldValues.isInitialized {return false}
    if self._version == nil {return false}
    if self._name == nil {return false}
    if !SwiftProtobuf.Internal.areAllInitialized(self.values) {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._name) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.features) }()
      case 3: try { try decoder.decodeRepeatedStringField(value: &self.keys) }()
      case 4: try { try decoder.decodeRepeatedMessageField(value: &self.values) }()
      case 5: try { try decoder.decodeSingularUInt32Field(value: &self._extent) }()
      case 15: try { try decoder.decodeSingularUInt32Field(value: &self._version) }()
      case 16..<536870912:
        try { try decoder.decodeExtensionField(values: &_protobuf_extensionFieldValues, messageType: VectorTile_Tile.Layer.self, fieldNumber: fieldNumber) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._name {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    if !self.features.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.features, fieldNumber: 2)
    }
    if !self.keys.isEmpty {
      try visitor.visitRepeatedStringField(value: self.keys, fieldNumber: 3)
    }
    if !self.values.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.values, fieldNumber: 4)
    }
    try { if let v = self._extent {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._version {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 15)
    } }()
    try visitor.visitExtensionFields(fields: _protobuf_extensionFieldValues, start: 16, end: 536870912)
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: VectorTile_Tile.Layer, rhs: VectorTile_Tile.Layer) -> Bool {
    if lhs._version != rhs._version {return false}
    if lhs._name != rhs._name {return false}
    if lhs.features != rhs.features {return false}
    if lhs.keys != rhs.keys {return false}
    if lhs.values != rhs.values {return false}
    if lhs._extent != rhs._extent {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    if lhs._protobuf_extensionFieldValues != rhs._protobuf_extensionFieldValues {return false}
    return true
  }
}
