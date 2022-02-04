import Foundation

public struct CainiaoEvent: Codable {
    // MARK: - Public varibales
    public let timeZone: String
    public let time: String
    public let desc: String
    public let status: String?

    public var endsTracking: Bool {
        eventStatus == .delivered
    }

    public var eventStatus: EventStatus {
        if desc.lowercased().contains("delivered") {
            return .delivered
        } else {
            return .forwarded
        }
    }
}
