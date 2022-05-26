import Foundation

// MARK: - EventStatus
public enum EventStatus: Int, Codable, SafeEnum {
    public static var unknownCase: EventStatus = .unknown

    case unknown                  = 0
    case posted                   = 1
    case outForDelivery           = 2
    case noTax                    = 3
    case tax                      = 4
    case forwarded                = 5
    case delivered                = 6
}

// MARK: - EventType
public enum EventType: String, Codable, SafeEnum {
    public static var unknownCase: EventType = .unknown
    
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
    case co = "CO"
    case cun = "CUN"
    case cmr = "CMR"
    case unknown

    var weight: Int {
        switch self {
        case .par:
            return 10
        case .ro:
            return 5
        case .po:
            return 1
        default:
            return 0
        }
    }
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
    public let complemento: String?

    init?(proxyAppAddress: ProxyAppAddress?) {
        guard let proxyAppAddress = proxyAppAddress else { return nil }
        cep = proxyAppAddress.cep
        logradouro = proxyAppAddress.logradouro
        numero = proxyAppAddress.numero
        localidade = proxyAppAddress.cidade
        uf = proxyAppAddress.uf
        bairro = proxyAppAddress.bairro
        codigo = nil
        latitude = nil
        longitude = nil
        complemento = nil
    }
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

    init?(proxyAppUnit: ProxyAppUnit?) {
        guard let proxyAppUnit = proxyAppUnit else { return nil }
        tipounidade = proxyAppUnit.tipo
        endereco = Address(proxyAppAddress: proxyAppUnit.endereco)
        codigo = proxyAppUnit.endereco?.cep
        cidade = proxyAppUnit.endereco?.cidade
        bairro = proxyAppUnit.endereco?.bairro
        uf = proxyAppUnit.endereco?.uf
        local = nil
        sto = nil
    }
}

// MARK: - Receiver
public final class Receiver: Codable {
    public let nome: String?
    public let documento: String?
    public let comentario: String?

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            nome = try? container.decodeIfPresent(String.self, forKey: .nome)
            documento = try? container.decodeIfPresent(String.self, forKey: .documento)
            comentario = try? container.decodeIfPresent(String.self, forKey: .comentario)
        } else if let container = try? decoder.singleValueContainer() {
            nome = try? container.decode(String.self)
            documento = nil
            comentario = nil
        } else {
            nome = nil
            documento = nil
            comentario = nil
        }
    }
}

// MARK: - Shipment
public final class Shipment: Codable {
    public let cepdestino: String?
    public let ar: String?
    public let mp: String?
    public let dh: String?
    public let peso: String?
    public let volume: String?
    public let dataprogramada: String?
    public let datapostagem: String?
    public let destinatario: String?
    public let prazotratamento: String?
    public let datatratamento: String?
    public let codigoservico: String?
}

// MARK: - DetalheOEC
public final class DetailOEC: Codable {
    public let carteiro: String?
    public let distrito: String?
    public let lista: String?
    public let unidade: String?
    public let endereco: Address?
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
    public let codigoServico: String?
    public let detalheOEC: DetailOEC?

    // MARK: - Computed variables
    public var eventStatus: EventStatus {
        guard let status = Int(status) else { return EventStatus.forwarded }

        switch (tipo, status) {
        case (.po, _):
            return .posted

        case (.oec, _), (.lde, _):
            return .outForDelivery

        case (.bde, 57), (.bdi, 57), (.bdr, 57),
             (.par, 34), (.par, 42):
            return .noTax

        case (.bde, 58), (.bde, 59),
             (.bdi, 58), (.bdi, 59),
             (.bdr, 58), (.bdr, 59),
             (.par, 17), (.fc, 26):
            return .tax

        case (.bde, 0), (.bde, 1), (.bde, 23),
             (.bde, 67), (.bde, 68), (.bde, 70):
            return .delivered

        case (.bdi, 0), (.bdi, 1), (.bdi, 23),
            (.bdi, 67), (.bdi, 68), (.bdi, 70):
            return .delivered

        case (.bdr, 0), (.bdr, 1), (.bdr, 23),
             (.bdr, 1), (.bdr, 68), (.bdr, 70):
            return .delivered

        default:
            return .forwarded
        }
    }

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

    init?(proxyAppEvent: CorreiosProxyAppEvent) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let dateTime = dateFormatter.date(from: proxyAppEvent.dtHrCriado) else { return nil }

        dateFormatter.dateFormat = "dd/MM/yyyy"
        data = dateFormatter.string(from: dateTime)

        dateFormatter.dateFormat = "HH:mm"
        hora = dateFormatter.string(from: dateTime)

        tipo = proxyAppEvent.codigo
        status = proxyAppEvent.tipo
        descricao = proxyAppEvent.descricao
        unidade = Unit(proxyAppUnit: proxyAppEvent.unidade)

        if let unidadeDestino = Unit(proxyAppUnit: proxyAppEvent.unidadeDestino) {
            destino = [unidadeDestino]
        } else {
            destino = nil
        }

        criacao = nil
        detalhe = nil
        recebedor = nil
        cepDestino = nil
        prazoGuarda = nil
        diasUteis = nil
        dataPostagem = nil
        postagem = nil
        codigoServico = nil
        detalheOEC = nil
    }
}
