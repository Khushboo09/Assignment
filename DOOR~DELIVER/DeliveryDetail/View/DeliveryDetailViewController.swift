import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {
    
    // Variables
    
    var detailView = DeliveryDetailView()
    var presenter: DeliveryDetailPresenterProtocol?
    
    // MARK: View life cycle
    override func loadView() {
        let backgroundView: UIView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.white
        self.view = backgroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizationConstant.detailVCTitle
        self.initialiseView()
        presenter?.showDeliveryDetail()
      
    }
        
    // MARK: Methods
    private func initialiseView() {
        self.view.addSubview(detailView)
        self.view.fullViewConstraints(detailView)
    }
}

extension DeliveryDetailViewController: DeliveryDetailViewProtocol {
    
     func showDeliveryDetail(for delivery: Product) {
        self.showPin(lat: delivery.location?.lattitude ?? 0.0, long: delivery.location?.longitude ?? 0.0, address: delivery.location?.address)
        let description: String = "\(delivery.description ?? "") at \(delivery.location?.address ?? "" )"
        self.refreshUI(description: description, imageUrl: delivery.imageURL)

     }
    func showPin(lat: Double, long: Double, address: String?) {
        self.detailView.removeMapViewPinAnnotation()
        self.addAnnotation(title: address ?? "", lattitude: lat, longitude: long)
    }
    func addAnnotation(title: String, lattitude: Double, longitude: Double) {
        self.detailView.addAnnotation(title: title, lattitude: lattitude, longitude: longitude)
    }
    
    func refreshUI(description: String?, imageUrl: String?) {
        self.detailView.setBottomViewDetails(descriptionText: description ?? "", imageUrl: imageUrl ?? "")
    }
}
