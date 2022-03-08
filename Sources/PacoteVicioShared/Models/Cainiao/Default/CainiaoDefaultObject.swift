public final class CainiaoDefaultObject<E: CainiaoEvent>: CainiaoObject {
    // MARK: - Variables
    public var originalTrackingCode: String?
    public var newTrackingCode: String?

    let companyName: String?
    let companyPhone: String?
    let url: String?
    let countryName: String?
    let detailList: [E]

    // MARK: - CainiaoObject
    public var events: [E] {
        detailList
    }

}
