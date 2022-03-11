import Foundation

public final class CainiaoDefaultEvent: CainiaoEvent {
    // MARK: - Public varibales
    let timeZone: String
    let time: String
    let desc: String
    let status: String?

    // MARK: - CainiaoEvent
    public var date: String {
        time
    }

    public var description: String {
        desc
    }

    public var eventStatus: EventStatus {
        if desc.lowercased().contains("delivered") {
            return .delivered
        } else {
            return .forwarded
        }
    }
}
