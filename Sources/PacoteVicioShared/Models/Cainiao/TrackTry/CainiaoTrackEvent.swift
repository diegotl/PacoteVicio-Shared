public final class CainiaoTrackEvent: CainiaoEvent {
    let details: String
    let statusDescription: String
    let checkpointStatus: String
    let substatus: String

    // MARK: - CainiaoEvent

    public let date: String

    public var description: String {
        statusDescription
    }

    public var eventStatus: EventStatus {
        if checkpointStatus == "info_received" {
            return .posted
        } else if checkpointStatus == "transit" {
            return .forwarded
        } else if checkpointStatus == "delivered" {
            return .delivered
        } else {
            return .forwarded
        }
    }

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case details = "Details"
        case statusDescription = "StatusDescription"
        case checkpointStatus = "checkpoint_status"
        case substatus
    }
}
