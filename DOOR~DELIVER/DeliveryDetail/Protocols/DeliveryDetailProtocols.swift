import UIKit

protocol DeliveryDetailViewProtocol: class {
    var presenter: DeliveryDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showDeliveryDetail(for delivery: Product) 
}

protocol DeliveryDetailWireFrameProtocol: class {
    static func createDeliveryDetailModule(for delivery: Product) -> UIViewController
}

protocol DeliveryDetailPresenterProtocol: class {
    var view: DeliveryDetailViewProtocol? { get set }
    var wireFrame: DeliveryDetailWireFrameProtocol? { get set }
    var delivery: Product? { get set }
    
    // VIEW -> PRESENTER
    func showDeliveryDetail()
}
