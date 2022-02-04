public final class CorreiosObject: Codable {

    // MARK: - Public Variables
    public let numero: String?
    public let sigla: String?
    public let nome: String?
    public let categoria: String?
    public let evento: [CorreiosEvent]?
    public let erro: String?

    // MARK: - Computed variables

    public var exists: Bool {
        return !(evento ?? []).isEmpty
    }

    public var eventStatus: EventStatus {
        evento?.first?.eventStatus ?? .unknown
    }
    
}
