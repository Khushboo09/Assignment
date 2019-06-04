import XCTest
import SwiftyJSON

@testable import DOOR_DELIVER
 var interactor = DeliveryListInteractor()
var productList: [Product]?
class DeliveryListInteractorTests: XCTestCase {
    
    var localDatamanager: CoreDataManagerTest?
    var remoteDatamanager: APIManagerTest?
    
    override func setUp() {
        
        localDatamanager = CoreDataManagerTest()
        remoteDatamanager = APIManagerTest()
        //remoteDatamanager?.remoteRequestHandler = remoteRequestHandler
        interactor.localDatamanager = localDatamanager
        interactor.remoteDatamanager = remoteDatamanager
    }
    
    override func tearDown() {
        localDatamanager = nil
        remoteDatamanager = nil
    }
    
    func testGetProductListWithEmptyLocalData() {
        localDatamanager?.isEmptyResponse = true
        interactor.retrieveDeliveryList(paging: Paging(offset: 0, limit: 20))
        XCTAssertEqual(productList?.count, 20)
    }

    func testRefreshList() {
        localDatamanager?.isEmptyResponse = true
        interactor.pullToRefresh(paging: Paging(offset: 0, limit: 20))
        XCTAssertEqual(productList?.count, 20)
    }
    
    func testSaveProducts() {
        let testRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        interactor.saveProductsIntoDB(products: [testRecord])
        do {
            let deliveryList = try localDatamanager?.retrieveDeliveryList(offset: 0, limit: 20)
            XCTAssertNotNil(deliveryList) } catch {}
        
    }
}

class CoreDataManagerTest: DeliveryListLocalDataManagerInputProtocol {
    
    func saveProduct(id: Int, address: String, imageURL: String, detail: String, latitude: Double, longitude: Double) throws -> DeliveryProduct {
        return mockCoredataRecord()
    }
    
    var isEmptyResponse: Bool = false
    
    func retrieveDeliveryList(offset: Int, limit: Int) throws -> [DeliveryProduct] {
        
        if isEmptyResponse == true {
            return []
        }
        let testRecord = mockCoredataRecord()
        
        return [testRecord]
    }
    
    func saveProduct(id: Int, address: String, imageURL: String, detail: String, latitude: Double, longitude: Double) throws {
        
    }
    
    func updateProduct(updatedProduct: Product) throws -> Bool {
        return false
    }
    
    func checkProductExists(productID: Int64) throws -> Bool {
        
        return false
    }
    
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
                _ = NSError(domain: "", code: 101, userInfo: [NSLocalizedDescriptionKey: "Something went wrong!"])
                 } else {
                let decoder = JSONDecoder()
                do {
                    guard let data = try response?.rawData() else {
                        return
                    }
                    let list = try decoder.decode(ProductList.self, from: data)
                     productList = list.productList
                    
                } catch {
                    print("error")
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
                } catch {
                    
                }
            } else {
                completionHandler(nil, nil)
            }
        } }
}
