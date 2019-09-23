//
//  Utility.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 23/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class Utility: NSObject {

    static func showNetworkError(from view: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) {
        showErrorAlert(with: "Seems like you have network issue, please connect and try again.", from: view)
    }
    
    static func showErrorAlert(with message: String, from view: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) {
        showAlert(title: "Oops!", with: message, from: view)
    }
    
    static func showAlert(title: String, with message: String, from view: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
}

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(red: 12/255.0, green: 95/255.0, blue: 168/255.0, alpha: 0.5).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

extension UIView {
    func setGradient() {
        self.backgroundColor = UIColor.clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = self.bounds
        self.layer.insertSublayer(backgroundLayer ?? CAGradientLayer(), at: 0)
    }
}

extension UIColor {
    static func appTheme() -> UIColor {
        return UIColor(red: 12/255.0, green: 95/255.0, blue: 168/255.0, alpha: 1.0)
    }
}
