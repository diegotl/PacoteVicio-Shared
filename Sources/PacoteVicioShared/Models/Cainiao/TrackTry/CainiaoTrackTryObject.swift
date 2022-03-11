public final class CainiaoTrackTryObject<E: CainiaoEvent>: CainiaoObject {
    // MARK: - Public variables
    public let trackingNumber: String

    // MARK: - Private variables
    let lastEvent: String
    let lastUpdateTime: String
    let trackinfo: [E]?
    let weblink: String

    enum CodingKeys: String, CodingKey {
        case lastEvent
        case lastUpdateTime
        case trackinfo
        case trackingNumber = "tracking_number"
        case weblink
    }

    // MARK: - CainiaoObject
    public var events: [E] {
        trackinfo ?? []
    }
}
