public protocol CainiaoObject: Decodable {
    associatedtype E: CainiaoEvent
    var events: [E] { get }
}

public extension CainiaoObject {
    var exists: Bool {
        !events.isEmpty
    }

    var eventStatus: EventStatus {
        events.first?.eventStatus ?? .unknown
    }
}
