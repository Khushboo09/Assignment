import UIKit

class DeliveryDetailBottomView: UIView {
    
    var imageView: UIImageView?
    var descriptionTextView: UITextView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeViews()
    }
    
    func initializeViews() {
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        descriptionTextView = UITextView()
        
        guard let imageView = imageView, let descriptionTextView = descriptionTextView else { return }
        
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(Constant.ImageDimension.kCellImageHeight)).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: CGFloat(Constant.ImageDimension.kCellImageWidth)).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.textAlignment = NSTextAlignment.natural
        descriptionTextView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        descriptionTextView.font=UIFont.systemFont(ofSize: Constant.fontSize)
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        descriptionTextView.isEditable = false
        setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
}
