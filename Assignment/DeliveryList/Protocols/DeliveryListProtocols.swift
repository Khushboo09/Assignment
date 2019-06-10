import UIKit

protocol DeliveryListViewProtocol: class {
    var presenter: DeliveryListPresenterProtocol? {get set}
    // PRESENTER -> VIEW
    func showProducts(with deliveries: [Product])
    func showError(errorMessage: String)
    func showLoading()
    func hideLoading()
    func showBottomLoading()
    func showNoDataLabel()
}

protocol DeliveryListWireFrameProtocol: class {
    static func createDeliveryListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
func presentDeliveryDetailScreen(view: DeliveryListViewProtocol, delivery: Product)
}

protocol DeliveryListPresenterProtocol: class {
    var view: DeliveryListViewProtocol? { get set }
    var interactor: DeliveryListInteractorInputProtocol? { get set }
    var wireFrame: DeliveryListWireFrameProtocol? { get set }
    // VIEW -> PRESENTER
    func fetchDeliveryList()
    func pullToRefresh()
    func showDeliveryDetail(delivery: Product)
    
}

protocol DeliveryListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveDeliveries(deliveries: [Product])
    func showLoading()
    func showNoDataLabel()
    func hideLoading()
    func showBottomLoading()
    func onError(errorMessage: String)
}

protocol DeliveryListInteractorInputProtocol: class {
    var presenter: DeliveryListInteractorOutputProtocol? { get set }
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func retrieveDeliveryList()
    func pullToRefresh()
    func showLoading()
}

protocol DeliveryListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol DeliveryListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: DeliveryListRemoteDataManagerOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveDeliveryList(_ params: [String: Any])
}

protocol DeliveryListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onDeliveryRetrieved(_ deliveries: ProductList)
    func onError(errorMessage: String)
}

protocol DeliveryListLocalDataManagerInputProtocol: class {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrieveDeliveryList(offset: Int, limit: Int) throws -> [DeliveryProduct]
    func saveProduct(id: Int, address: String, imageURL: String, detail: String, latitude: Double, longitude: Double) throws -> DeliveryProduct
    func removeProducts()throws 
}
