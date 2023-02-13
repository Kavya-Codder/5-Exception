//
//  ViewController.swift
//  5 Exceptins
//
//  Created by Kavya Prajapati on 11/02/23.
//

import UIKit

enum LoginValidation: String {
    case email = "Please enter email"
    case password = "Please enter password"
    case validEmail = "Please entet valide Email"
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var dbObject: DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        
//        let userDefault = UserDefaults.standard
//        let value = userDefault.bool(forKey: UserKeys.isLoggedIn.rawValue)
//        if value {
//            pushToDeshboardVC()
//        }
    }
    
    @IBAction func onClickTxtEmail(_ sender: Any) {
        lblEmail.isHidden = false
    }
    
    @IBAction func onClickTxtPassword(_ sender: Any) {
        lblPassword.isHidden = false
    }
    
    @IBAction func onClickLoginBtn(_ sender: Any) {
        let validation = doValidation()
        if validation.0 {
            let isLoging = dbObject.CheckForUserEmailAndPasswordMatch(userEmail: txtEmail.text ?? "", password: txtPassword.text ?? "")
            if isLoging {
                pushToDeshboardVC()
            } else {
                showAlert(title: "Error", message: "Email or password does not match", hendler: nil)
            }
        } else {
            showAlert(title: "Errore", message: validation.1, hendler: nil)
        }
    }
    
    @IBAction func onClickSignUpBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

// Extension
extension LoginVC {
    
    func pushToDeshboardVC() {
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func initialSetUp() {
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        viewContainer.clipsToBounds = true
        viewContainer.layer.cornerRadius = 25
        viewContainer.layer.shadowColor = UIColor.darkGray.cgColor
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewContainer.layer.shadowRadius = 0.5
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.masksToBounds = false
        
        btnLogin.clipsToBounds = true
        btnLogin.layer.cornerRadius = 25
        
        
    }
    
    func doValidation() -> (Bool, String) {
        if (txtEmail.text?.isEmpty ?? false) {
            return(false, LoginValidation.email.rawValue)
            
        } else if (txtPassword.text?.isEmpty ?? false) {
            return(false, LoginValidation.password.rawValue)
            
        } else if !self.isValidEmailAddress(txtEmail.text ?? "") {
            return (false, LoginValidation.validEmail.rawValue)
            
        }
        return(true, "")
    }
    
}
