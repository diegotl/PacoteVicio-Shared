// MARK: - CorreiosProxyAppEvent
final class CorreiosProxyAppEvent: Codable {
    let codigo: EventType
    let tipo: String
    let dtHrCriado: String
    let descricao: String
    let unidade: ProxyAppUnit?
    let unidadeDestino: ProxyAppUnit?
}

// MARK: - ProxyAppUnit
final class ProxyAppUnit: Codable {
    let endereco: ProxyAppAddress?
    let tipo: String?
    let codSro: String?
    let nome: String?
}

// MARK: - ProxyAppAddress
final class ProxyAppAddress: Codable {
    let cidade: String?
    let uf: String?
    let bairro: String?
    let cep: String?
    let logradouro: String?
    let numero: String?
}
