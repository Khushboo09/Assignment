import Foundation
import UIKit

class Constraints {
    
    static func topConstraint(view: UIView, secondView: UIView, constant: CGFloat) {
        view.topAnchor.constraint(equalTo: secondView.topAnchor, constant: constant).isActive = true
    }
    
    static func topWithBottomConstraint(view: UIView, secondView: UIView, constant: CGFloat) {
        view.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: constant).isActive = true
    }
    
    static func leadingConstraint(view: UIView, secondView: UIView, constant: CGFloat) {
        view.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: constant).isActive = true
    }
    
    static func leadingWithTrailingConstraint(view: UIView, secondView: UIView, constant: CGFloat) {
        view.leadingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: constant).isActive = true
    }
    
    static func trailingConstraint(view: UIView, secondView: UIView, constant: CGFloat) {
        view.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: constant).isActive = true
    }
    
    static func bottomConstraint(view: UIView, secondView: UIView, constant: CGFloat) {
        view.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: constant).isActive = true
    }
    
    static func centerXConstraint(view: UIView, secondView: UIView) {
        view.centerXAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
    }
    
    static func centerYConstraint(view: UIView, secondView: UIView) {
        view.centerYAnchor.constraint(equalTo: secondView.centerYAnchor).isActive = true
    }
    
    static func widthConstraint(view: UIView, constant: CGFloat) {
        view.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    static func heightConstraint(view: UIView, constant: CGFloat) {
        view.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    static func minimumHeightConstraint(view: UIView, constant: CGFloat) {
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
}
