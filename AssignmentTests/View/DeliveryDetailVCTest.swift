import XCTest
var iscalled = false
@testable import Assignment
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
    
}

class DeliveryDetailTest: DeliveryDetailViewProtocol {
    var presenter: DeliveryDetailPresenterProtocol?
    
    func showDeliveryDetail(for delivery: Product) {
        iscalled = true
    }
}
