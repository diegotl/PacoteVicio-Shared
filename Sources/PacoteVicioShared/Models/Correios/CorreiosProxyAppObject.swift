// MARK: - PostalType
final class PostalType: Codable {
    let categoria: String
    let descricao: String
    let sigla: String
}

// MARK: - CorreiosProxyAppObject
public final class CorreiosProxyAppObject: Codable {
    let codObjeto: String
    let mensagem: String?
    let eventos: [CorreiosProxyAppEvent]?
    let tipoPostal: PostalType?
}
