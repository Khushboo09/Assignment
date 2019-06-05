import UIKit
import MapKit

let kDetailMapAnnotattion = "DetailMapAnnotation"
class DeliveryDetailView: UIView, MKMapViewDelegate {
    
    var mapView: MKMapView = MKMapView()
    var pinAnnotation = MKPointAnnotation()
    var bottomDetailView = DeliveryDetailBottomView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeViews()
    }
    
    // MARK: Methods
    func initializeViews() {
        self.addMap()
        self.addBottomView()
    }
    
    func addMap() {
        mapView.delegate = self
        self.addSubview(mapView)
        self.fullViewConstraints(mapView)
    }
    
    func addBottomView() {
        if self.subviews.contains(bottomDetailView) {
            self.willRemoveSubview(bottomDetailView)
        }
        
        self.addSubview(bottomDetailView)
        bottomDetailView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        bottomDetailView.translatesAutoresizingMaskIntoConstraints = false
        bottomDetailView.layer.borderWidth = 0.5
        bottomDetailView.layer.borderColor = UIColor.gray.cgColor
        bottomDetailView.setLeadingConstraint(secondView: self, constant: Constant.Dimension.trailingspacingDetailView.rawValue)
        bottomDetailView.setTrailingConstraint(secondView: self, constant: -Constant.Dimension.trailingspacingDetailView.rawValue)
        bottomDetailView.setBottomConstraint(secondView: self, constant: -Constant.Dimension.bottomspacingDetailView.rawValue)
    }
}

// MARK: Refreshing the data
extension DeliveryDetailView {
    func addAnnotation(title: String, lattitude: Double, longitude: Double) {
        pinAnnotation = MKPointAnnotation()
        pinAnnotation.title = title
        pinAnnotation.coordinate = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        mapView.addAnnotation(pinAnnotation)
        
        let region = MKCoordinateRegion(center: pinAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.mapView.setRegion(region, animated: true)
    }
    
    func removeMapViewPinAnnotation() {
        self.mapView.removeAnnotation(pinAnnotation)
    }
    
    func setBottomViewDetails(descriptionText: String, imageUrl: String) {
        self.bottomDetailView.descriptionTextView?.text = descriptionText
        self.bottomDetailView.imageView?.sd_setImage(with: URL.init(string: imageUrl), completed: nil)
    }
}

// MARK: MKMapView delegate
extension DeliveryDetailView {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = kDetailMapAnnotattion
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
