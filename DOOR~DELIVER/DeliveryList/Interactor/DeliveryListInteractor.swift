enum APIKeys: String {
    case offsetKey = "offset"
    case limitKey = "limit"
}

class DeliveryListInteractor: DeliveryListInteractorInputProtocol {
    
    weak var presenter: DeliveryListInteractorOutputProtocol?
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol?
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol?
    private var isDataLoading = false
    private var refreshStatus: Int?
    
    func retrieveDeliveryList(paging: Paging) {
        do {
            guard let deliveryList = try localDatamanager?.retrieveDeliveryList(offset: paging.offset, limit: paging.limit)else {
                self.updateOnError(error: LocalizationConstant.coredataerror)
                return
            }
            if deliveryList.isEmpty {
                if paging.offset == 0 {
                    refreshStatus = paging.offset
                    presenter?.showLoading()
                } else {
                    presenter?.showBottomLoading()
                }
                if !isDataLoading {
                    self.getDeliveryListFromServer(offset: paging.offset, limit: paging.limit)
                }
            } else {
                presenter?.didRetrieveDeliveries(deliveries: deliveryList.map {
                    return Product(id: Int($0.id), address: $0.address ?? "", detail: $0.detail ?? "", lattitude: $0.latitude, longitude: $0.longitude, imageURL: $0.imageURL ?? "")
                })
            }
        } catch {
            
        }
    }
    
    func pullToRefresh(paging: Paging) {
        if !isDataLoading {
            getDeliveryListFromServer(offset: paging.offset, limit: paging.limit)
        }
    }
    
    func getDeliveryListFromServer(offset: Int, limit: Int) {
        let parameters = [APIKeys.offsetKey.rawValue: offset, APIKeys.limitKey.rawValue: limit]
        guard ConnectivityManager.isConnectedToInternet() else {
            self.updateOnError(error: LocalizationConstant.interneterror)
            return
        }
        isDataLoading = true
        print(1)
        remoteDatamanager?.retrieveDeliveryList(parameters)
    }
    
    func updateOnError(error: String) {
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
        presenter?.didRetrieveDeliveries(deliveries: deliveries.productList)
        self.saveProductsIntoDB(products: deliveries.productList)
    }
    
    func saveProductsIntoDB(products: [Product]) {
        if refreshStatus == 0 {
            do {
                try localDatamanager?.removeProducts()
            } catch {
            }
        }
        for productModel in products {
            do {
                _ = try localDatamanager?.saveProduct(id: productModel.id ?? 0, address: productModel.location?.address ?? "", imageURL: productModel.imageURL ?? "", detail: productModel.description ?? "", latitude: productModel.location?.lattitude ?? 0, longitude: productModel.location?.longitude ?? 0)
            } catch {
            }
        }
    }
    
}
