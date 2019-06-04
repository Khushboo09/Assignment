import XCTest
import CoreData
@testable import DOOR_DELIVER

class DeliveryListLocalDataManagerTest: XCTestCase {

    let containerName = "Assignment"
    let entityName = "DeliveryProduct"
    let offset = 0
    let limit = 20
    let coreDataManager = DeliveryListLocalDataManager()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: containerName, managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        if let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))]) {
            return managedObjectModel
        }
        return NSManagedObjectModel()
    }()
    
    private func mockRecordData() -> Product {
        let aRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        return aRecord
    }

    func testInsertRecord() {
        let testRecord = mockRecordData()
        do {
            let product = try coreDataManager.saveProduct(id: testRecord.id ?? 0, address: testRecord.location?.address ?? "", imageURL: testRecord.imageURL ?? "", detail: testRecord.description ?? "", latitude: testRecord.location?.lattitude ?? 0, longitude: testRecord.location?.longitude ?? 0)
            let mockRecord = DeliveryProduct(context: CoreDataStore.managedObjectContext!)
           mockRecord.address  = product.address
            XCTAssertEqual(testRecord.location?.address, mockRecord.address)
        } catch {
        }
    }
    
    func testRetrieveDeliveryList() {
         let testRecord = mockRecordData()
        
        do {
            _ = try coreDataManager.saveProduct(id: testRecord.id ?? 0, address: testRecord.location?.address ?? "", imageURL: testRecord.imageURL ?? "", detail: testRecord.description ?? "", latitude: testRecord.location?.lattitude ?? 0, longitude: testRecord.location?.longitude ?? 0)
        let deliveryList = try coreDataManager.retrieveDeliveryList(offset: offset, limit: limit)
             XCTAssertNotNil(deliveryList)
        } catch {}
        
    }
    
    func testUpdateProductSuccess() {
        var testRecord = mockRecordData()
        testRecord.description = "Changed Description"
        do {
            let product = try coreDataManager.updateProduct (updatedProduct: testRecord)
            XCTAssertEqual("true", product.description)
        } catch {}
       
    }
}
