public final class CainiaoTrackTryObject<E: CainiaoEvent>: CainiaoObject {
    let lastEvent: String
    let lastUpdateTime: String
    let status: String
    let trackUpdate: Bool
    let trackinfo: [E]
    let trackingNumber: String
    let weblink: String

    enum CodingKeys: String, CodingKey {
        case lastEvent
        case lastUpdateTime
        case status
        case trackUpdate = "track_update"
        case trackinfo
        case trackingNumber = "tracking_number"
        case weblink
    }

    // MARK: - CainiaoObject
    public var events: [E] {
        trackinfo
    }
}
