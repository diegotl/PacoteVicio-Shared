public protocol CainiaoObjectProtocol: Decodable {
    associatedtype E: CainiaoEvent
    var events: [E] { get }
}

public extension CainiaoObjectProtocol {
    var exists: Bool {
        !events.isEmpty
    }

    var eventStatus: EventStatus {
        events.first?.eventStatus ?? .unknown
    }
}
