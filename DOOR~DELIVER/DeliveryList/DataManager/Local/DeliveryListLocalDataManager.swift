import CoreData

class DeliveryListLocalDataManager: DeliveryListLocalDataManagerInputProtocol {
    
    func retrieveDeliveryList(offset: Int, limit: Int) throws -> [DeliveryProduct] {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request: NSFetchRequest<DeliveryProduct> = NSFetchRequest(entityName: String(describing: DeliveryProduct.self))
        request.fetchOffset = offset
        request.fetchLimit = limit
        return try managedOC.fetch(request)
    }
    
    func saveProduct(id: Int, address: String, imageURL: String, detail: String, latitude: Double, longitude: Double) throws -> DeliveryProduct {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        if let newProduct = NSEntityDescription.entity(forEntityName: String(describing: DeliveryProduct.self), in: managedOC) {
            let product = DeliveryProduct(entity: newProduct, insertInto: managedOC)
            product.id = Int64(id)
            product.address = address
            product.detail = detail
            product.imageURL = imageURL
            product.latitude = latitude
            product.longitude = longitude
            try managedOC.save()
            return product
        }
        throw PersistenceError.couldNotSaveObject
    }
    
    func removeProducts()throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: DeliveryProduct.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try managedOC.execute(deleteRequest)
        try managedOC.save()
    }
}
