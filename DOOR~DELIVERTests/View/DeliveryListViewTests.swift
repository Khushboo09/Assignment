import XCTest
@testable import DOOR_DELIVER

class DeliveryListViewTests: XCTestCase {
    let deliveryListView = DeliveryListViewController()
    
    override func setUp() {
        let tableView = deliveryListView.listTableView
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifier.listCell)
    }
    
    override func tearDown() {
    }
    
    func testTableViewDelegate() {
        XCTAssertTrue(deliveryListView.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewDataSource() {
        XCTAssertTrue(deliveryListView.conforms(to: UITableViewDataSource.self))
    }
    
    func testConfigureCell() {
        let product = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        deliveryListView.deliveryList.append(product)
        let tableView = deliveryListView.listTableView
        let cell = deliveryListView.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! DeliveryTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.descLabel.text, product.description! + " at " + (product.location?.address)!)
    }
    
    func testNumberOfRowsInSection() {
        let tableView = deliveryListView.listTableView
        XCTAssertNotNil(deliveryListView.tableView(tableView, numberOfRowsInSection: 0))
    }
    
    func testTableViewMethods() {
        let tableView = deliveryListView.listTableView
        XCTAssertNotNil(deliveryListView.tableView(tableView, numberOfRowsInSection: 0))
        XCTAssertNotNil(deliveryListView.tableView(tableView, estimatedHeightForRowAt: IndexPath(row: 0, section: 0)))
    }
    
    func testCellConfigureWithEmptyValues() {
        deliveryListView.deliveryList.removeAll()
        let testRecord = Product(id: 0, address: "This is sample address", detail: "", lattitude: 22.2200134, longitude: 37.9220012, imageURL: "This is sample image url")
        deliveryListView.deliveryList.append(testRecord)
        let tableView = deliveryListView.listTableView
        let cell = deliveryListView.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! DeliveryTableViewCell
        XCTAssertEqual(cell.descLabel.text, testRecord.description! + " at " + (testRecord.location?.address)!)
    }
    
    func testshowLoading() {
        deliveryListView.showLoading()
        XCTAssertNotNil(ActivityIndicator.activityIndicator)
        
    }
    
    func testhideLoading() {
        deliveryListView.hideLoading()
        XCTAssertNotNil(ActivityIndicator.activityIndicator)
         XCTAssertTrue(!ActivityIndicator.activityIndicator.isAnimating)
        
    }
    
    func testshowBottomLoading() {
       deliveryListView.showBottomLoading()
        XCTAssertNotNil(ActivityIndicator.activityIndicator)
    }
    
    func testshowProducts() {
        let testRecord = Product(id: 0, address: "This is sample address", detail: "", lattitude: 22.2200134, longitude: 37.9220012, imageURL: "This is sample image url")
        deliveryListView.showProducts(with: [testRecord])
        XCTAssertNotNil(deliveryListView.listTableView)
    }
    
}
