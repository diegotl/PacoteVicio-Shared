// MARK: - TrackingMoreResponse
final class TrackingMoreResponse: Decodable {
    let code: Int
    let data: [TrackingMoreData]
    let message: String
    let status: String
}

// MARK: - TrackingMoreData
final class TrackingMoreData: Decodable {
    let lang: String
    let lastInfo: String
    let lastTime: String
    let originData: CainiaoTrackingMoreObject<CainiaoTrackEvent>
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
final class CainiaoTrackingMoreObject<E: CainiaoEvent>: CainiaoObject {
    let departfromAirport: String
    let itemReceived: String
    let lastUpdateTime: String
    let statusInfo: String
    let substatus: String
    let trackinfo: [E]
    let weblink: String

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
    var events: [E] {
        trackinfo
    }
}
