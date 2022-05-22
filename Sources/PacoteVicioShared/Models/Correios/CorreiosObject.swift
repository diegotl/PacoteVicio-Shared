public final class CorreiosObject: Codable {

    // MARK: - Public Variables
    public let numero: String?
    public let sigla: String?
    public let nome: String?
    public let categoria: String?
    public var evento: [CorreiosEvent]?
    public let erro: String?

    // MARK: - Computed variables

    public var exists: Bool {
        return !(evento ?? []).isEmpty
    }

    public var eventStatus: EventStatus {
        evento?.first?.eventStatus ?? .unknown
    }

    // MARK: - Init
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numero = try container.decodeIfPresent(String.self, forKey: .numero)
        sigla = try container.decodeIfPresent(String.self, forKey: .sigla)
        nome = try container.decodeIfPresent(String.self, forKey: .nome)
        categoria = try container.decodeIfPresent(String.self, forKey: .categoria)
        evento = try container.decodeIfPresent([CorreiosEvent].self, forKey: .evento)
        erro = try container.decodeIfPresent(String.self, forKey: .erro)

        // Handle when Correios returns all events with same date and time
        // https://i.ibb.co/LRnK9G1/correiosfdp.png
        if let evento = evento,
           evento.count > 1,
           let firstEventDate = evento.first?.data,
           let firstEventTime = evento.first?.hora,
           evento.allSatisfy({ $0.data == firstEventDate && $0.hora == firstEventTime }) {
            self.evento = evento.sorted(by: { lhs, rhs in
                lhs.tipo.weight > rhs.tipo.weight
            })
        }
    }
    
}
