import UIKit

class DeliveryListWireFrame: DeliveryListWireFrameProtocol {
    
    static func createDeliveryListModule() -> UIViewController {
        
        let view = DeliveryListViewController()
        let navController = UINavigationController(rootViewController: view)
       
            let presenter: DeliveryListPresenterProtocol & DeliveryListInteractorOutputProtocol = DeliveryListPresenter()
            let interactor: DeliveryListInteractorInputProtocol & DeliveryListRemoteDataManagerOutputProtocol = DeliveryListInteractor()
            let localDataManager: DeliveryListLocalDataManagerInputProtocol = DeliveryListLocalDataManager()
            let remoteDataManager: DeliveryListRemoteDataManagerInputProtocol = DeliveryListRemoteDataManager()
            let wireFrame: DeliveryListWireFrameProtocol = DeliveryListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }

    func presentDeliveryDetailScreen(view: DeliveryListViewProtocol, delivery: Product) {
        let deliveryDetailViewController = DeliveryDetailWireFrame.createDeliveryDetailModule(for: delivery)

        if let sourceView = view as? UIViewController {
           sourceView.navigationController?.pushViewController(deliveryDetailViewController, animated: true)
        }
    }
    
}
