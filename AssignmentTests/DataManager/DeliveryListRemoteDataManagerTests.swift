import XCTest
@testable import Assignment

class DeliveryListRemoteDataManagerTests: XCTestCase {
    
    let host = "mock-api-mobile.dev.lalamove.com"
    
    func testDeliveryList(params: [String: Any]) {
        XCStub.request(withPathRegex: host, withResponseFile: "MockDeliveryData.json")
        let promise = expectation(description: "expected data from the json file")
        let urlStr = Endpoints.Deliveries.fetch.url
        var params: [String: Any] = ["offset": 0]
        params["limit"] = 20
        DeliveryListRemoteDataManager().apiGet(serviceName: urlStr, parameters: params) { (json, error) in
            XCTAssertNotNil(json)
            promise.fulfill()
            
        }
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTAssertNotNil(error, "Webservice response returns with error")
            }
        }
    }
    
    func testFailureDeliveryData() {
        XCStub.request(withPathRegex: host, withResponseFile: "MockDeliveryData_Invalid.json")
        let promise = expectation(description: "expected error from the invalid json file")
        let urlStr = Endpoints.Deliveries.fetch.url
        var params: [String: Any] = ["offset": 0]
        params["limit"] = 20
        
        DeliveryListRemoteDataManager().apiGet(serviceName: urlStr, parameters: params) { (json, error) in
            XCTAssertNotNil(error)
            promise.fulfill()
        }
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTAssertNotNil(error, "Webservice response returns with error")
            }
        }
    }
    
}
