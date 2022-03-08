import Foundation

public final class CainiaoDefaultEvent: CainiaoEvent {
    // MARK: - Public varibales
    let timeZone: String
    let time: String
    let desc: String
    let status: String?

    // MARK: - CainiaoEvent
    public var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else { return time }

        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(timeZone) ?? 0 * 3600)
        return dateFormatter.string(from: date)
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
