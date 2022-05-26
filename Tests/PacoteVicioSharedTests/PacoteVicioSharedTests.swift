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

    func testCorreiosObjectDecodesProxyAppResponse() throws {
        // Given
        let json = """
{"codObjeto":"LE449872154SE","eventos":[{"codigo":"BDE","descricao":"Objeto entregue ao destinatário","dtHrCriado":"2022-02-08T11:16:53","tipo":"01","unidade":{"endereco":{"cidade":"CAMPINAS","uf":"SP"},"tipo":"Unidade de Distribuição"},"urlIcone":"/public-resources/img/smile.png"},{"codigo":"OEC","descricao":"Objeto saiu para entrega ao destinatário","dtHrCriado":"2022-02-08T09:40:31","tipo":"01","unidade":{"endereco":{"bairro":"JARDIM DO LAGO","cep":"13050973","cidade":"CAMPINAS","logradouro":"RUA DOS GRAFICOS","numero":"510","uf":"SP"},"tipo":"Unidade de Distribuição"},"urlIcone":"/public-resources/img/pre-atendimento-cor.png"},{"codigo":"RO","descricao":"Objeto em trânsito - por favor aguarde","dtHrCriado":"2022-02-07T13:43:32","tipo":"01","unidade":{"endereco":{"cidade":"INDAIATUBA","uf":"SP"},"tipo":"Unidade de Tratamento"},"unidadeDestino":{"endereco":{"cidade":"CAMPINAS","uf":"SP"},"tipo":"Unidade de Distribuição"},"urlIcone":"/public-resources/img/caminhao-cor.png"},{"codigo":"RO","descricao":"Objeto em trânsito - por favor aguarde","dtHrCriado":"2022-02-04T16:26:09","tipo":"01","unidade":{"endereco":{"cidade":"CURITIBA","uf":"PR"},"tipo":"Unidade de Tratamento"},"unidadeDestino":{"endereco":{"cidade":"INDAIATUBA","uf":"SP"},"tipo":"Unidade de Tratamento"},"urlIcone":"/public-resources/img/caminhao-cor.png"},{"codigo":"PAR","descricao":"Fiscalização aduaneira finalizada","dtHrCriado":"2022-02-04T16:24:09","tipo":"10","unidade":{"endereco":{"cidade":"CURITIBA","uf":"PR"},"tipo":"Unidade Operacional"},"urlIcone":"/public-resources/img/verificar-documento-cor.png"},{"codigo":"PAR","descricao":"Pagamento confirmado","dtHrCriado":"2022-02-04T04:22:36","tipo":"31","unidade":{"endereco":{"cidade":"CURITIBA","uf":"PR"},"tipo":"Unidade de Logística Integrada"},"urlIcone":"/public-resources/img/fatura-paga.png"},{"codigo":"PAR","descricao":"Aguardando pagamento","dtHrCriado":"2022-02-02T23:17:58","tipo":"17","unidade":{"endereco":{"cidade":"CURITIBA","uf":"PR"},"tipo":"Unidade de Logística Integrada"},"urlIcone":"/public-resources/img/aguardando-pagamento.png"},{"codigo":"PAR","descricao":"Encaminhado para fiscalização aduaneira","dtHrCriado":"2022-01-31T09:40:21","tipo":"21","unidade":{"endereco":{"cidade":"CURITIBA","uf":"PR"},"tipo":"Unidade de Logística Integrada"},"urlIcone":"/public-resources/img/caminhao-cor.png"},{"codigo":"PAR","descricao":"Objeto recebido pelos Correios do Brasil","dtHrCriado":"2022-01-24T14:58:19","tipo":"16","unidade":{"endereco":{"cidade":"CURITIBA","uf":"PR"},"tipo":"Unidade Operacional"},"urlIcone":"/public-resources/img/brazil.png"},{"codigo":"RO","descricao":"Objeto em trânsito - por favor aguarde","dtHrCriado":"2022-01-19T17:29:00","tipo":"01","unidade":{"codSro":"00752000","endereco":{},"nome":"SUECIA","tipo":"País"},"unidadeDestino":{"codSro":"00500001","endereco":{"uf":"BR"},"nome":"Unidade de Tratamento Internacional","tipo":"País"},"urlIcone":"/public-resources/img/caminhao-cor.png"},{"codigo":"PO","descricao":"Objeto postado","dtHrCriado":"2022-01-19T17:28:00","tipo":"01","unidade":{"codSro":"00752000","endereco":{},"nome":"SUECIA","tipo":"País"},"urlIcone":"/public-resources/img/agencia-cor.png"},{"codigo":"PAR","descricao":"Objeto recebido na unidade de exportação no país de origem","dtHrCriado":"2022-01-19T17:28:00","tipo":"18","unidade":{"codSro":"00752000","endereco":{},"nome":"SUECIA","tipo":"País"},"urlIcone":"/public-resources/img/receber-encomenda-cor.png"}],"modalidade":"V","tipoPostal":{"categoria":"PRIME IMPORTAÇÃO","descricao":"OBJETO INTERNACIONAL PRIME","sigla":"LE"},"habilitaAutoDeclaracao":false,"permiteEncargoImportacao":false,"habilitaPercorridaCarteiro":false,"bloqueioObjeto":false,"possuiLocker":false,"habilitaLocker":false,"habilitaCrowdshipping":false}
"""
        let jsonData = json.data(using: .utf8)!

        // When
        let correiosProxyAppObject = try JSONDecoder().decode(CorreiosProxyAppObject.self, from: jsonData)
        let correiosObject = CorreiosObject(proxyAppObject: correiosProxyAppObject)
        

        // Then
        XCTAssertNotNil(correiosProxyAppObject.eventos)
        XCTAssertNotNil(correiosObject.evento)
        XCTAssertEqual(correiosProxyAppObject.eventos.count, 12)
        XCTAssertEqual(correiosObject.evento!.count, 12)
    }
}
