import XCTest
import SwiftyJSON
import OHHTTPStubs
@testable import Assignment

class DeliveryListInteractorTests: XCTestCase, DeliveryListRemoteDataManagerOutputProtocol {
    var interactor = DeliveryListInteractor()
    var localDatamanager: CoreDataManagerTest?
    var remoteDatamanager: APIManagerTest?
    var error: String = ""
    
    override func setUp() {
        localDatamanager = CoreDataManagerTest()
        remoteDatamanager = APIManagerTest()
        remoteDatamanager?.remoteRequestHandler = self
        interactor.localDatamanager = localDatamanager
        interactor.remoteDatamanager = remoteDatamanager
    }
    
    override func tearDown() {
        localDatamanager = nil
        remoteDatamanager = nil
    }
    
    func testRetrieveDeliveryListWithRemoteData() {
        localDatamanager?.isEmptyResponse = true
        interactor.retrieveDeliveryList()
        XCTAssertEqual(interactor.productList.count, 20)
    }
    
    func testRetrieveDeliveryListWithLocalData() {
        localDatamanager?.isEmptyResponse = false
        interactor.retrieveDeliveryList()
        XCTAssertEqual(interactor.productList.count, 1)
    }
    
    func testPullToListWithRemoteData() {
        localDatamanager?.isEmptyResponse = true
        interactor.pullToRefresh()
        XCTAssertEqual(interactor.productList.count, 20)
    }
    
    func testPullToRefreshWhenNoLocalData() {
        localDatamanager?.isEmptyResponse = false
        remoteDatamanager?.isError = true
        interactor.pullToRefresh()
        XCTAssertEqual(interactor.productList.count, 0)
    }
    
    func testRetrieveDeliveryListWithError() {
        localDatamanager?.isEmptyResponse = true
        remoteDatamanager?.isError = true
        interactor.retrieveDeliveryList()
        XCTAssertEqual(error, "Something went wrong!")
    }
    
    func onDeliveryRetrieved(_ deliveries: ProductList) {
        interactor.onDeliveryRetrieved(deliveries)
    }
    
    func onError(errorMessage: String) {
        error = errorMessage
        interactor.onError(errorMessage: errorMessage)
    }
}

class InteractorTest: XCTestCase {
    
    var interactor = DeliveryListInteractor()
    
    func testRetrieveDeliveryDBListWithError() {
        let list = interactor.retrieveListFromDB(offset: -5, limit: 0)
        XCTAssertEqual(list.count, 0)
    }
    
}

class CoreDataManagerTest: DeliveryListLocalDataManagerInputProtocol {
    
    func retrieveDeliveryList(offset: Int, limit: Int) throws -> [DeliveryProduct] {
        if isEmptyResponse == true {
            return []
        }
        
        let testRecord = mockCoredataRecord()
        
        return [testRecord]
    }
    
    func saveProduct(id: Int, address: String, imageURL: String, detail: String, latitude: Double, longitude: Double) throws -> DeliveryProduct {
        return mockCoredataRecord()
    }
    
    var isEmptyResponse: Bool = false
    var isError: Bool = false
    
    func removeProducts() throws {
        
    }
    private func mockCoredataRecord() -> DeliveryProduct {
        let mockRecord = DeliveryProduct(context: CoreDataStore.managedObjectContext!)
        
        mockRecord.address = "Mock Address"
        mockRecord.id = 0
        mockRecord.detail = "Mock Description"
        mockRecord.latitude = 22.334
        mockRecord.longitude = 123.39
        mockRecord.imageURL = "Mock Url"
        return mockRecord
    }
}
class APIManagerTest: DeliveryListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DeliveryListRemoteDataManagerOutputProtocol?
    
    var isError = false
    
    func retrieveDeliveryList(_ params: [String: Any]) {
        self.api(serviceName: Endpoints.Deliveries.fetch.url, parameters: params) { (response, error) in
            if self.isError == true {
                self.remoteRequestHandler?.onError(errorMessage: error?.localizedDescription ?? "")
            } else {
                let decoder = JSONDecoder()
                do {
                    guard let data = try response?.rawData() else {
                        return
                    }
                    let list = try decoder.decode(ProductList.self, from: data)
                    
                    self.remoteRequestHandler?.onDeliveryRetrieved(list)
                } catch {
                    self.remoteRequestHandler?.onError(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func api(serviceName: String, parameters: [String: Any]?, completionHandler: @escaping (JSON?, NSError?) -> Void) {
        if isError == true {
            let error = NSError(domain: "", code: 101, userInfo: [NSLocalizedDescriptionKey: "Something went wrong!"])
            completionHandler(nil, error)
        } else {
            let bundel = Bundle(for: type(of: self))
            let path = bundel.path(forResource: "MockDeliveryData", ofType: "json")
            let data = NSData(contentsOfFile: path ?? "")
            if let data = data {
                do {
                    let json = try JSON(data: data as Data)
                    completionHandler(json, nil)
                } catch let error {
                    print(error)
                }            } else {
                completionHandler(nil, nil)
            }
        } }
}
