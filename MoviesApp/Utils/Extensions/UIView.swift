//
//  UIView.swift
//
//
//

import UIKit

extension UIView {
    
    var hiddenWithSubViews: Bool {
         set {
             isHidden = newValue
             subviews.forEach { (v) in
                 v.isHidden = newValue
             }
         }
         get {
             return isHidden
         }
     }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.backgroundColor = UIColor.green.cgColor
        self.layer.mask = rectShape

    }

    @IBInspectable var setRightCorners: CGFloat {
        get {
            return  0
        }
        set {
            if #available(iOS 11.0, *){
                self.clipsToBounds = false
                self.layer.cornerRadius = newValue
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }else{
                roundCorners([.topRight , .bottomRight], radius: newValue)
            }
        }
    }
    
    @IBInspectable var setLeftCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
                }else{
                    roundCorners([.topLeft , .bottomLeft], radius: newValue)
                }
            }
        }
    }
    
    
    @IBInspectable var setTopCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                }else{
                    roundCorners([.topRight , .topLeft], radius: newValue)
                }
            }
        }
    }
    
    
    @IBInspectable var setBottomCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                }else{
                    roundCorners([.bottomRight , .bottomLeft], radius: newValue)
                }
            }
        }
    }
    
    @IBInspectable var setBottomLeftCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMinXMaxYCorner]
                }else{
                    roundCorners([.bottomLeft], radius: newValue)
                }
            }
        }
    }
    
    @IBInspectable var setBottomRightCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMaxXMaxYCorner]
                }else{
                    roundCorners([.bottomRight], radius: newValue)
                }
            }
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow(shadowColor:UIColor.black.cgColor )
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    @IBInspectable var circleCornerRadius: Bool {
        get {
            return self.layer.cornerRadius == self.frame.height / 2
        }
        set {
            
            if newValue == true {
                self.layer.cornerRadius = self.bounds.height / 2
            }
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var SetShadowColor: UIColor {
        get {
            return UIColor.black.withAlphaComponent(0.08)
        }
        set {
            self.addShadow(shadowColor: newValue.cgColor )
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.withAlphaComponent(0.08).cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 2),
                   shadowOpacity: Float = 1,
                   shadowRadius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor//shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func addTapGesture(tapNumber : Int, target: Any , action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }

}
//MARK: - Animations
extension UIView {
    func slideFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
        
    }
    
    func slideFromBottom(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromBottomTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromBottomTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromBottomTransition.type = CATransitionType.push
        slideInFromBottomTransition.subtype = CATransitionSubtype.fromTop
        slideInFromBottomTransition.duration = duration
        slideInFromBottomTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        slideInFromBottomTransition.fillMode = CAMediaTimingFillMode.both
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromBottomTransition, forKey: "slideInFromBottomTransition")
        
    }
    
    func applyCustomGradient() {
        let colorTop = UIColor(red: 0.933, green: 1, blue: 0.972, alpha: 1).cgColor
        let colorBottom =  UIColor.white.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}


@IBDesignable class roundView: UIView {
    override func didMoveToWindow() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}
