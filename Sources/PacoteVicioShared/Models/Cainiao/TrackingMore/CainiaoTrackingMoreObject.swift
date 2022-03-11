// MARK: - TrackingMoreResponse
public final class TrackingMoreResponse: Decodable {
    // MARK: - Public variables
    public let code: Int
    public let data: [TrackingMoreData]

    // MARK: - Private variables
    let message: String
    let status: String
}

// MARK: - TrackingMoreData
public final class TrackingMoreData: Decodable {
    // MARK: - Public variables
    public let originData: CainiaoTrackingMoreObject<CainiaoTrackEvent>

    // MARK: - Private variables
    let lang: String
    let lastInfo: String
    let lastTime: String
    let trackNumber: String

    enum CodingKeys: String, CodingKey {
        case lang
        case lastInfo = "last_info"
        case lastTime = "last_time"
        case originData = "origin_data"
        case trackNumber = "track_number"
    }
}

// MARK: - CainiaoTrackingMoreObject
public final class CainiaoTrackingMoreObject<E: CainiaoEvent>: CainiaoObject {
    let departfromAirport: String?
    let itemReceived: String?
    let lastUpdateTime: String?
    let statusInfo: String?
    let substatus: String?
    let trackinfo: [E]?
    let weblink: String?

    enum CodingKeys: String, CodingKey {
        case departfromAirport = "DepartfromAirport"
        case itemReceived = "ItemReceived"
        case lastUpdateTime
        case statusInfo
        case substatus
        case trackinfo
        case weblink
    }

    // MARK: - CainiaoObject
    public var events: [E] {
        trackinfo ?? []
    }
}
