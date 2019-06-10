import XCTest
@testable import Assignment

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
        
        let tableView = deliveryListView.listTableView
        let cell = deliveryListView.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! DeliveryTableViewCell
        XCTAssertNotNil(cell)
        
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
    
    func testShowLoading() {
        deliveryListView.showLoading()
        XCTAssertNotNil(ActivityIndicator.activityIndicator)
    }
    
    func testHideLoading() {
        deliveryListView.hideLoading()
        XCTAssertNotNil(ActivityIndicator.activityIndicator)
        XCTAssertNotNil(deliveryListView.bottomactivityIndicator)
    }
    
    func testShowBottomLoading() {
        deliveryListView.showBottomLoading()
        XCTAssertNotNil(deliveryListView.bottomactivityIndicator)
    }
    
    func testShowProducts() {
        let testRecord = Product(id: 0, address: "This is sample address", detail: "", lattitude: 22.2200134, longitude: 37.9220012, imageURL: "This is sample image url")
        deliveryListView.showProducts(with: [testRecord])
        XCTAssertNotNil(deliveryListView.listTableView)
    }
    
}
