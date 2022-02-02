// MARK: - EventType

public enum EventType: String, Codable {
    case bde = "BDE"
    case bdi = "BDI"
    case bdr = "BDR"
    case blq = "BLQ"
    case par = "PAR"
    case est = "EST"
    case ro = "RO"
    case `do` = "DO"
    case fc = "FC"
    case lde = "LDE"
    case ldi = "LDI"
    case oec = "OEC"
    case po = "PO"
    case unknown
}

// MARK: - Address

public final class Address: Codable {
    public let codigo: String?
    public let cep: String?
    public let logradouro: String?
    public let numero: String?
    public let localidade: String?
    public let uf: String?
    public let bairro: String?
    public let latitude: String?
    public let longitude: String?
}

// MARK: - Unit

public final class Unit: Codable {
    public let local: String?
    public let codigo: String?
    public let cidade: String?
    public let bairro: String?
    public let uf: String?
    public let sto: String?
    public let tipounidade: String?
    public let endereco: Address?
}

// MARK: - Receiver

public final class Receiver: Codable {}

// MARK: - Shipment

public final class Shipment: Codable {
    public let cepdestino: String?
    public let ar: String?
    public let mp: String?
    public let dh: String?
    public let peso: String?
    public let volume: String?
    public let dataprogramada: String?
    public let destinatario: String?
    public let datapostagem: String?
    public let prazotratamento: String?
    public let datatratamento: String?
    public let codigoservico: String?
}

// MARK: - CorreiosEvent

public final class CorreiosEvent: Codable {
    // MARK: - Minimal

    public let tipo: EventType
    public let status: String
    public let data: String
    public let hora: String
    public let descricao: String

    // MARK: - Optional

    public let criacao: String?
    public let detalhe: String?
    public let recebedor: Receiver?
    public let unidade: Unit?
    public let destino: [Unit]?
    public let cepDestino: String?
    public let prazoGuarda: String?
    public let diasUteis: String?
    public let dataPostagem: String?
    public let postagem: Shipment?

    // MARK: - Computed variables

//    var eventStatus: Int {
//        guard let status = Int(status) else { return EventStatus.forwarded }
//
//        switch (tipo, status) {
//        case (.po, _):
//            return EventStatus.posted
//
//        case (.oec, _), (.lde, _):
//            return EventStatus.outForDelivery
//
//        case (.bde, 57), (.bdi, 57), (.bdr, 57),
//             (.par, 34), (.par, 42):
//            return EventStatus.noTax
//
//        case (.bde, 58), (.bde, 59),
//             (.bdi, 58), (.bdi, 59),
//             (.bdr, 58), (.bdr, 59),
//             (.par, 17), (.fc, 26):
//            return EventStatus.tax
//
//        case (.bde, 0), (.bde, 1), (.bde, 23),
//             (.bde, 67), (.bde, 68), (.bde, 70):
//            return EventStatus.delivered
//
//        case (.bdi, 0), (.bdi, 1), (.bdi, 23),
//            (.bdi, 67), (.bdi, 68), (.bdi, 70):
//            return EventStatus.delivered
//
//        case (.bdr, 0), (.bdr, 1), (.bdr, 23),
//             (.bdr, 1), (.bdr, 68), (.bdr, 70):
//            return EventStatus.delivered
//
//        default:
//            return EventStatus.forwarded
//        }
//    }

    public var endsTracking: Bool {
        guard let status = Int(status) else { return false }

        if [.bdi, .bde, .bdr].contains(tipo), [1, 12, 23, 50, 51, 52, 43, 67, 68, 70, 71, 72, 73, 74, 75, 76, 80].contains(status) {
            return true
        }

        if tipo == .fc, status == 11 {
            return true
        }

        return false
    }

    public var taxed: Bool {
        guard let status = Int(status) else { return false }

        switch (tipo, status) {
        case (.bde, 58), (.bde, 59),
             (.bdi, 58), (.bdi, 59),
             (.bdr, 58), (.bdr, 59),
             (.par, 17), (.fc, 26):
            return true

        default:
            return false
        }
    }

    public var postalFee: Bool {
        guard let status = Int(status) else { return false }

        switch (tipo, status) {
        case (.par, 30):
            return true
        default:
            return false
        }
    }
}
