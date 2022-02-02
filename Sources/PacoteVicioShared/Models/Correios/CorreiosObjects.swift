import CryptoKit
import Foundation

public final class CorreiosObject: Codable {

    // MARK: - Public Variables
    public let numero: String?
    public let categoria: String?
    public let sigla: String?
    public let nome: String?
    public let evento: [CorreiosEvent]?
    public let erro: String?

    // MARK: - Computed variables

    var exists: Bool {
        return !(evento ?? []).isEmpty
    }

//    var eventStatus: Int {
//        evento?.first?.eventStatus ?? EventStatus.unknown
//    }

//    // MARK: - Public functions

    func hash() -> String? {
        guard
            let numero = numero,
            let mostRecentEvent = evento?.first
        else {
            return nil
        }

        let source = numero + mostRecentEvent.data + mostRecentEvent.hora + mostRecentEvent.descricao
        return SHA256.hash(data: Data(source.utf8)).hex
    }
}
