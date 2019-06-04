import XCTest
@testable import DOOR_DELIVER
import MapKit
import CoreData

class DeliveryDetailViewControllerTests: XCTestCase {
    
    let detailViewController = DeliveryDetailViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        detailViewController.loadView()
        
        detailViewController.viewDidLoad()
        
        XCTAssertNotNil(detailViewController)
        
        XCTAssertNotNil(detailViewController.detailView)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMethods() {
        detailViewController.addAnnotation(title: "Test", lattitude: 22.9987, longitude: 123.299)
        XCTAssertNotNil(detailViewController.detailView.pinAnnotation)
        
        detailViewController.showPin(lat: 22.2929, long: 122.0088, address: "Address")
        XCTAssertNotNil(detailViewController.detailView.pinAnnotation)
        
        detailViewController.refreshUI(description: "Test", imageUrl: "ImageUrl")
        XCTAssertNotNil(detailViewController.detailView.pinAnnotation)
    }
    
    private func mockRecordData() -> Product {
        let aRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        return aRecord
    }
    
    func testshowDeliveryDetail() {
        let testRecord = mockRecordData()
        detailViewController.showDeliveryDetail(for: testRecord)
        
        XCTAssertEqual(testRecord.location?.lattitude, detailViewController.detailView.pinAnnotation.coordinate.latitude)
        XCTAssertEqual(testRecord.location?.longitude, detailViewController.detailView.pinAnnotation.coordinate.longitude)
    
    }
    
}
