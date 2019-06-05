class DeliveryListPresenter: DeliveryListPresenterProtocol {
    weak var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInteractorInputProtocol?
    var wireFrame: DeliveryListWireFrameProtocol?
    
    func fetchDeliveryList(paging: Paging) {
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
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func showBottomLoading() {
        view?.showBottomLoading()
    }
    
    func didRetrieveDeliveries(deliveries: [Product]) {
        view?.showProducts(with: deliveries)
    }
    
    func onError(errorMessage: String) {
        view?.showError(errorMessage: errorMessage)
    }
    
}
