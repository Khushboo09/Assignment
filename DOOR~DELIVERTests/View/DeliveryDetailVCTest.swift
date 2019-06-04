//
//  DeliveryDetailPresenter.swift
//  DOOR~DELIVERTests
//
//  Created by Kanika on 31/05/19.
//

import XCTest
@testable import DOOR_DELIVER

var iscalled = false

class DeliveryDetailVCTest: XCTestCase {
    
    let presenter = DeliveryDetailPresenter()
    var deliveryDetail: DeliveryDetailTest?
    
    override func setUp() {
        deliveryDetail = DeliveryDetailTest()
        presenter.view = deliveryDetail
        presenter.delivery = self.mockRecordData()
    }
    
    override func tearDown() {
        
       deliveryDetail = nil
        
    }
    
    private func mockRecordData() -> Product {
        let aRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        return aRecord
    }

    func testShowDeliveryDetail() {
        
        presenter.showDeliveryDetail()
        XCTAssertTrue(iscalled)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class DeliveryDetailTest: DeliveryDetailViewProtocol {
    var presenter: DeliveryDetailPresenterProtocol?
    
    func showDeliveryDetail(for delivery: Product) {
        iscalled = true
    }
}
