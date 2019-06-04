class DeliveryDetailPresenter: DeliveryDetailPresenterProtocol {
    
    weak var view: DeliveryDetailViewProtocol?
    var wireFrame: DeliveryDetailWireFrameProtocol?
    var delivery: Product?
    
    func showDeliveryDetail() {
        guard let product = delivery
            else {return}
        view?.showDeliveryDetail(for: product)
    }
}
