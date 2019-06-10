import UIKit
class DeliveryTableViewCell: UITableViewCell {
    
    let productImageView = UIImageView()
    let descLabel = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(productImageView)
        addSubview(descLabel)
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.font = UIFont.systemFont(ofSize: Constant.fontSize)
        setConstraint()
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
    }
    
    func setConstraint() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        productImageView.setTopConstraint(secondView: self, constant: Constant.Dimension.spacing.rawValue)
        productImageView.setLeadingConstraint(secondView: self, constant: Constant.Dimension.spacing.rawValue)
        productImageView.setWidthConstraint(constant: Constant.Dimension.imageHieghtWidth.rawValue)
        productImageView.setHeight(constant: Constant.Dimension.imageHieghtWidth.rawValue)
        descLabel.setTopConstraint(secondView: self, constant: Constant.Dimension.spacing.rawValue)
        descLabel.setLeadingWithTrailingConstraint(secondView: productImageView, constant: Constant.Dimension.spacing.rawValue)
        descLabel.setTrailingConstraint(secondView: self, constant: -Constant.Dimension.trailingspacing.rawValue)
        descLabel.setBottomConstraint(secondView: self, constant: -Constant.Dimension.spacing.rawValue)
        descLabel.setMinimunHeight(constant: Constant.Dimension.height.rawValue)
    }
    
}
