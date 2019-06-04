class DeliveryListPresenter: DeliveryListPresenterProtocol {
    weak var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInteractorInputProtocol?
    var wireFrame: DeliveryListWireFrameProtocol?
    
    func fetchDeliveryList(paging: Paging) {
        if paging.offset == 0 {
            view?.showLoading()
        } else {
            view?.showBottomLoading()
        }
        interactor?.retrieveDeliveryList(paging: paging)
    }
    
    func pullToRefresh(paging: Paging) {
        interactor?.pullToRefresh(paging: paging)
    }
    
    func showDeliveryDetail(delivery: Product) {
        
        wireFrame?.presentDeliveryDetailScreen(view: view!, delivery: delivery)
    }

}

extension DeliveryListPresenter: DeliveryListInteractorOutputProtocol {
    
    func didRetrieveDeliveries(deliveries: [Product]) {
        view?.hideLoading()
        view?.showProducts(with: deliveries)
    }
    
    func onError(errorMessage: String) {
        view?.hideLoading()
        view?.showError(errorMessage: errorMessage)
    }
    
}
