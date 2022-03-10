public final class CainiaoDefaultObject<E: CainiaoEvent>: CainiaoObject {
    // MARK: - Public variables
    public var originalTrackingCode: String?
    public var newTrackingCode: String?

    // MARK: - Private variables
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
