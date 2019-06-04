enum APIKeys: String {
    case offsetKey = "offset"
    case limitKey = "limit"
}

enum ErrorMessege: String {
    case internetError = "Please check your internet connection!"
    case other = "Something went wrong."
    case coreDataError = "Failed to fetch deliveries. Please pull to refresh."
}

class DeliveryListInteractor: DeliveryListInteractorInputProtocol {
    
    weak var presenter: DeliveryListInteractorOutputProtocol?
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol?
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol?
    
    func retrieveDeliveryList(paging: Paging) {
        
        do {
            guard let deliveryList = try localDatamanager?.retrieveDeliveryList(offset: paging.offset, limit: paging.limit)else {
                self.updateOnError(error: ErrorMessege.coreDataError.rawValue)
                return
            }
            if deliveryList.isEmpty {
                self.getDeliveryListFromServer(offset: paging.offset, limit: paging.limit)
            } else {
                presenter?.didRetrieveDeliveries(deliveries: deliveryList.map {
                    
                    return Product(id: Int($0.id), address: $0.address ?? "", detail: $0.detail ?? "", lattitude: $0.latitude, longitude: $0.longitude, imageURL: $0.imageURL ?? "")
                    
                })
            }} catch {}
    }
    
    func pullToRefresh(paging: Paging) {
        guard ConnectivityManager.isConnectedToInternet() else {
            self.updateOnError(error: ErrorMessege.internetError.rawValue)
            
            return
        }
        getDeliveryListFromServer(offset: paging.offset, limit: paging.limit)
    }
    
    func getDeliveryListFromServer(offset: Int, limit: Int) {
        let parameters = [APIKeys.offsetKey.rawValue: offset, APIKeys.limitKey.rawValue: limit]
        guard ConnectivityManager.isConnectedToInternet() else {
            self.updateOnError(error: ErrorMessege.internetError.rawValue)
            
            return
        }
        remoteDatamanager?.retrieveDeliveryList(parameters)
    }
    
    func updateOnError(error: String) {
        presenter?.onError(errorMessage: error)
    }
}

extension DeliveryListInteractor: DeliveryListRemoteDataManagerOutputProtocol {
    
    func onError(errorMessage: String) {
        
        self.updateOnError(error: errorMessage)
        
    }
    
    func onDeliveryRetrieved(_ deliveries: ProductList) {
        
        presenter?.didRetrieveDeliveries(deliveries: deliveries.productList)
        self.saveProductsIntoDB(products: deliveries.productList)
        
    }
    
      func saveProductsIntoDB(products: [Product]) {
            for productModel in products {
                
                do {
                    if try localDatamanager?.checkProductExists(productID: Int64(productModel.id ?? 0)) ?? false {
                        do {
                            _ = try localDatamanager?.updateProduct(updatedProduct: productModel)
                        } catch {}
                    } else {
                        do {
                            _ = try localDatamanager?.saveProduct(id: productModel.id ?? 0, address: productModel.location?.address ?? "", imageURL: productModel.imageURL ?? "", detail: productModel.description ?? "", latitude: productModel.location?.lattitude ?? 0, longitude: productModel.location?.longitude ?? 0)
                        } catch {}}
                } catch {}}
              }

}
