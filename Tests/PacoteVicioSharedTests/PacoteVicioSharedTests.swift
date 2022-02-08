import XCTest
@testable import PacoteVicioShared

final class PacoteVicioSharedTests: XCTestCase {

    private class TestObject: Codable {
        let eventType: EventType
    }

    func testPredictedEventType() throws {
        // Given
        let json = "{\"eventType\":\"BDE\"}"
        let jsonData = json.data(using: .utf8)!

        // When
        let testObject = try JSONDecoder().decode(TestObject.self, from: jsonData)

        // Then
        XCTAssertEqual(testObject.eventType, .bde)
    }

    func testUnpredictedEventType() throws {
        // Given
        let json = "{\"eventType\":\"UNK\"}"
        let jsonData = json.data(using: .utf8)!

        // When
        let testObject = try JSONDecoder().decode(TestObject.self, from: jsonData)

        // Then
        XCTAssertEqual(testObject.eventType, .unknown)
    }
}
