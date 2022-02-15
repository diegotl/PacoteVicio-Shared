import Foundation

public struct CainiaoEvent: Codable {
    // MARK: - Public varibales
    public let timeZone: String
    public let time: String
    public let desc: String
    public let status: String?

    public var endsTracking: Bool {
        eventStatus == .delivered
    }

    public var eventStatus: EventStatus {
        if desc.lowercased().contains("delivered") {
            return .delivered
        } else {
            return .forwarded
        }
    }

    public var processedTitle: String? {
        switch desc.lowercased() {
        case "accepted by carrier":
            return "Aceito pela transportadora"

        case "delivered":
            return "Objeto entregue ao destinatário"

        default:
            return desc
        }
    }

    public var processedDescription: String? {
        switch status?.lowercased() {
        case "pickedup":
            return "Pacote coletado"

        case "depart_from_original_country":
            return "Deixou o país de origem"

        case "arrived_at_dest_country":
            return "Chegou ao país de destino"

        case "signin":
            return nil

        default:
            return status
        }
    }
}
