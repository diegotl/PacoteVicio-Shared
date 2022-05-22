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

    func testSortsWhenCorreiosEventsHaveSameDatetime() throws {
        // Given
        let json = """
{"numero":"LY245491512DK","sigla":"LY","nome":"OBJETO INTERNACIONAL PRIME","categoria":"PRIME IMPORTAÇÃO","evento":[{"tipo":"RO","status":"01","data":"21/05/2022","hora":"05:49","criacao":"21052022054900","descricao":"Objeto em trânsito - por favor aguarde","unidade":{"local":"DINAMARCA","codigo":"00208000","sto":"99999999","tipounidade":"País","endereco":{"codigo":"37763","latitude":"56.26392","longitude":"9.501785"}},"destino":[{"local":"Unidade de Tratamento Internacional","codigo":"00500001","uf":"BR","endereco":{"codigo":"77159","uf":"BR","latitude":"-14.235004","longitude":"-51.92528"}}],"cepDestino":"00000000","prazoGuarda":"0","dataPostagem":"21/05/2022"},{"tipo":"PO","status":"01","data":"21/05/2022","hora":"05:49","criacao":"21052022054900","descricao":"Objeto postado","unidade":{"local":"DINAMARCA","codigo":"00208000","sto":"99999999","tipounidade":"País","endereco":{"codigo":"37763","latitude":"56.26392","longitude":"9.501785"}},"postagem":{"cepdestino":"44640000","ar":"N","mp":"N","dh":"N","peso":"0","volume":"0","dataprogramada":"01/01/1900 00:00:00","datapostagem":"01/01/1900 00:00:00","prazotratamento":"0"},"cepDestino":"44640000","prazoGuarda":"0","diasUteis":"0","dataPostagem":"21/05/2022"},{"tipo":"PAR","status":"18","data":"21/05/2022","hora":"05:49","criacao":"21052022054900","descricao":"Objeto recebido na unidade de exportação no país de origem","unidade":{"local":"DINAMARCA","codigo":"00208000","sto":"99999999","tipounidade":"País","endereco":{"codigo":"37763","latitude":"56.26392","longitude":"9.501785"}},"cepDestino":"00000000","prazoGuarda":"0","dataPostagem":"21/05/2022"}]}
"""
        let jsonData = json.data(using: .utf8)!

        // When
        let correiosObject = try JSONDecoder().decode(CorreiosObject.self, from: jsonData)

        // Then
        XCTAssertNotNil(correiosObject.evento)
        XCTAssertEqual(correiosObject.evento!.count, 3)
        XCTAssertEqual(correiosObject.evento![0].tipo, .par)
        XCTAssertEqual(correiosObject.evento![1].tipo, .ro)
        XCTAssertEqual(correiosObject.evento![2].tipo, .po)
    }
}
