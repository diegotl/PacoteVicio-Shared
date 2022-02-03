/// Assigns unknown case for new unexpected values
public protocol SafeEnum: RawRepresentable, CaseIterable where RawValue: Equatable & Codable {
    static var unknownCase: Self { get }
}

public extension SafeEnum {
    init(rawValue: RawValue) {
        let value = Self.allCases.first { $0.rawValue == rawValue }
        self = value ?? Self.unknownCase
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        let value = Self(rawValue: rawValue)
        self = value ?? Self.unknownCase
    }
}
