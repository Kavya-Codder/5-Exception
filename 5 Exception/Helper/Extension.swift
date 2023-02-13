//
//  ViewController.swift
//  5 Exceptins
//
//  Created by Kavya Prajapati on 11/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, hendler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: hendler)
        alertVC.addAction(ok)
        self.present(alertVC, animated: true, completion: nil)
    }
    func displayAlert(with title: String?, message: String?, buttons: [String], buttonStyles: [UIAlertAction.Style] = [], handler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        for i in 0 ..< buttons.count {
            let style: UIAlertAction.Style = buttonStyles.indices.contains(i) ? buttonStyles[i] : .default
            let buttonTitle = buttons[i]
            let action = UIAlertAction(title: buttonTitle, style: style) { (_) in
                handler(buttonTitle)
            }
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
    // MARK: - Email Validations
    func isValidEmailAddress(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

