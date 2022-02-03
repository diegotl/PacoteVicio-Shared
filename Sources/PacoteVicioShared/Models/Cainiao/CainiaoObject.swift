import CryptoKit
import Foundation

public struct CainiaoObject: Codable {
    // MARK: - Variables
    public var originalTrackingCode: String?
    public var newTrackingCode: String?

    public let companyName: String?
    public let companyPhone: String?
    public let url: String?
    public let countryName: String?
    public let detailList: [CainiaoEvent]

    // MARK: - Computed variables
    public var exists: Bool {
        !detailList.isEmpty
    }

    public var eventStatus: EventStatus {
        detailList.first?.eventStatus ?? .unknown
    }

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case companyName
        case companyPhone
        case url
        case countryName
        case detailList
    }

    // MARK: - Public functions

    public func hash() -> String? {
        guard let mostRecentEvent = detailList.first else { return nil }
        let source = [originalTrackingCode, newTrackingCode, mostRecentEvent.time, mostRecentEvent.desc, mostRecentEvent.status].compactMap({ $0 }).joined()
        return SHA256.hash(data: Data(source.utf8)).hex
    }
}
