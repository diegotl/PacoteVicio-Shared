public protocol CainiaoEvent: Decodable {
    var date: String { get }
    var description: String { get }
    var eventStatus: EventStatus { get }
}

public extension CainiaoEvent {
    var endsTracking: Bool {
        eventStatus == .delivered
    }
}
