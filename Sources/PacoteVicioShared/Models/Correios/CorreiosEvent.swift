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

}
