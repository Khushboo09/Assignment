enum APIKeys: String {
    case offsetKey = "offset"
    case limitKey = "limit"
}

class DeliveryListInteractor: DeliveryListInteractorInputProtocol {
    
    weak var presenter: DeliveryListInteractorOutputProtocol?
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol?
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol?
    var isDataLoading = false
    var offset: Int = 0
    var productList = [Product]()
    
    func retrieveDeliveryList() {
        let list = self.retrieveListFromDB(offset: offset, limit: Constant.pagingLimit)
        if list.isEmpty { isDataLoading ? nil :
            self.getDeliveryListFromServer(offset: offset, limit: Constant.pagingLimit)
        } else {
            productList += list.map {
                return Product(id: Int($0.id), address: $0.address ?? "", detail: $0.detail ?? "", lattitude: $0.latitude, longitude: $0.longitude, imageURL: $0.imageURL ?? "")
            }
            self.offset = productList.count
            presenter?.hideLoading()
            presenter?.didRetrieveDeliveries(deliveries: productList)
        }
    }
    
    func showLoading() {
        if self.offset == 0 {
            presenter?.showLoading()
        } else {
            presenter?.showBottomLoading()
        }
    }
    
    func retrieveListFromDB(offset: Int, limit: Int) -> [DeliveryProduct] {
        do {
            guard let deliveryList = try localDatamanager?.retrieveDeliveryList(offset: offset, limit: limit)else {
                self.updateOnError(error: LocalizationConstant.coreDataError)
                return []
            }
            return deliveryList
        } catch let error {
            self.updateOnError(error: error.localizedDescription)
        }
        return []
    }
    
    func pullToRefresh() {
        offset = 0
        isDataLoading ? nil : getDeliveryListFromServer(offset: offset, limit: Constant.pagingLimit)
    }
    
    func getDeliveryListFromServer(offset: Int, limit: Int) {
        let parameters = [APIKeys.offsetKey.rawValue: offset, APIKeys.limitKey.rawValue: limit]
        guard ConnectivityManager.isConnectedToInternet() else {
            self.updateOnError(error: LocalizationConstant.internetError)
            return
        }
        isDataLoading = true
        print(1)
        remoteDatamanager?.retrieveDeliveryList(parameters)
    }
    
    func updateOnError(error: String) {
        productList.isEmpty ? presenter?.showNoDataLabel() : nil
        presenter?.hideLoading()
        presenter?.onError(errorMessage: error)
    }
}

extension DeliveryListInteractor: DeliveryListRemoteDataManagerOutputProtocol {
    
    func onError(errorMessage: String) {
        isDataLoading = false
        self.updateOnError(error: errorMessage)
    }
    
    func onDeliveryRetrieved(_ deliveries: ProductList) {
        isDataLoading = false
        presenter?.hideLoading()
        self.offset == 0 ? productList.removeAll() : nil
        self.productList += deliveries.productList
        offset = self.productList.count
        presenter?.didRetrieveDeliveries(deliveries: self.productList)
        if !deliveries.productList.isEmpty {
            self.saveProductsIntoDB(products: deliveries.productList)
        }
    }
    
    func saveProductsIntoDB(products: [Product]) {
        do {
            try localDatamanager?.removeProducts()
        } catch let error {
            self.updateOnError(error: error.localizedDescription)
        }
        for productModel in products {
            do {
                _ = try localDatamanager?.saveProduct(id: productModel.id ?? 0, address: productModel.location?.address ?? "", imageURL: productModel.imageURL ?? "", detail: productModel.description ?? "", latitude: productModel.location?.lattitude ?? 0, longitude: productModel.location?.longitude ?? 0)
            } catch let error {
                self.updateOnError(error: error.localizedDescription)
            }
        }
    }
    
}
