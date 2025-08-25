//
//  UIViewController+LoadingIndicator.swift
//  MoviesApp
//
//  Created by OSX on 10/07/2025.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func displaySpinner(onView : UIView) -> UIView {
        let loaderColor = UIColor.blue
       let animationFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
       let animationView = NVActivityIndicatorView(frame: animationFrame, type: NVActivityIndicatorType.ballPulse, color:loaderColor, padding: 10)
       DispatchQueue.main.async {
           animationView.center = onView.center
           onView.addSubview(animationView)
       }
       animationView.startAnimating()
       return animationView
   }
   
    func removeSpinner(spinner :UIView) {
       DispatchQueue.main.async {
           spinner.removeFromSuperview()
       }
   }
}
