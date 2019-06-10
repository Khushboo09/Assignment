import Foundation
import UIKit

extension UIView {
    
    func setBorder(color: UIColor, borderWidth: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }
    
    func setTopConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.topConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setTopWithBottomConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.topWithBottomConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setBottomConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.bottomConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setLeadingConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.leadingConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setTrailingConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.trailingConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setLeadingWithTrailingConstraint(secondView: UIView, constant: CGFloat) {
        Constraints.leadingWithTrailingConstraint(view: self, secondView: secondView, constant: constant)
    }
    
    func setCenterXConstraint(secondView: UIView) {
        Constraints.centerXConstraint(view: self, secondView: secondView)
    }
    
    func setCenterYConstraint(secondView: UIView) {
        Constraints.centerYConstraint(view: self, secondView: secondView)
    }
    
    func setWidthConstraint(constant: CGFloat) {
        Constraints.widthConstraint(view: self, constant: constant)
    }
    
    func setHeight(constant: CGFloat) {
        Constraints.heightConstraint(view: self, constant: constant)
    }
    
    func setMinimunHeight(constant: CGFloat) {
        Constraints.minimumHeightConstraint(view: self, constant: constant)
    }
    
    func fullViewConstraints(_ subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": subView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": subView]))
    }
    
    public func setAutoresizingMaskIntoConstraintsForAllSubviews() {
        for view in self.subviews {
            view.setAutoresizingMaskIntoConstraintsForAllSubviews()
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
