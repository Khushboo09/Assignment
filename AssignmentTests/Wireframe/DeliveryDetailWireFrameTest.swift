import XCTest
@testable import Assignment

class DeliveryDetailWireFrameTest: XCTestCase {
    
    func testCreateDeliveryDetailModule() {
        let testRecord = Product(id: 0, address: "This is sample address", detail: "", lattitude: 22.2200134, longitude: 37.9220012, imageURL: "This is sample image url")
        let viewController = DeliveryDetailWireFrame.createDeliveryDetailModule(for: testRecord)
        XCTAssertNotNil(viewController)
        XCTAssertTrue(viewController is DeliveryDetailViewController)
    }
}
