import UIKit

class DeliveryDetailWireFrame: DeliveryDetailWireFrameProtocol {
    
    class func createDeliveryDetailModule(for delivery: Product) -> UIViewController {
      
            let view = DeliveryDetailViewController()
            let presenter: DeliveryDetailPresenterProtocol = DeliveryDetailPresenter()
            let wireFrame: DeliveryDetailWireFrameProtocol = DeliveryDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.delivery = delivery
            presenter.wireFrame = wireFrame
            
        return view
        
    }
}
