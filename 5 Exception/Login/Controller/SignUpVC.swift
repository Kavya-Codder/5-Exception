//
//  ViewController.swift
//  5 Exceptins
//
//  Created by Kavya Prajapati on 11/02/23.
//

import UIKit

enum SignUpValidation: String {
    case name = "Please enter name"
    case email = "Please enter email"
    case password = "Please enter password"
    case con_Password = "Please conferm password"
    case passwordMatch = "Password does not match"
    case phone = "Please entet phone no."
    case phonev1 = "Mobile number should be greater than or equal to 10 digits"
    case phonev2 = "Please entet vaide phone no"
    case validEmail = "Please entet valide Email"
}

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnSignUP: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConPassword: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    var dbObject: DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
    @IBAction func onClickTxtName(_ sender: Any) {
        lblName.isHidden = false
    }
    
    @IBAction func onClickTxtEmail(_ sender: Any) {
        lblEmail.isHidden = false
    }
    
    @IBAction func onClickTxtPassword(_ sender: Any) {
        lblPassword.isHidden = false
    }
    
    @IBAction func onClickTxtConPassword(_ sender: Any) {
        lblConPassword.isHidden = false
    }
    
    
    @IBAction func onClickTxtPhone(_ sender: Any) {
        lblPhone.isHidden = false
    }
    
    
    @IBAction func onClickSignUp(_ sender: Any) {
        let validation = doValidation()
        if validation.0 {
            let dict = ["id": Int32.random(in: 1..<50), "name": txtName.text ?? "", "email": txtEmail.text ?? "", "password": txtPassword.text ?? "", "mobileNo": txtPhone.text ?? ""] as [String : Any]
            dbObject.insertData(object: dict)
           showAlert(title: "Success", message: "Registered successfully") { (str) in
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            showAlert(title: "Errore", message: validation.1, hendler: nil)
        }
    }
    
    @IBAction func onClickSignInBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
}
//MARK:- Custom FUnction
extension SignUpVC {
    
    func initialSetUp() {
        btnSignUP.layer.cornerRadius = 20
        btnSignUP.clipsToBounds = true
        
        viewContainer.clipsToBounds = true
        viewContainer.layer.cornerRadius = 35
        viewContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func doValidation() -> (Bool, String) {
        if (txtName.text?.isEmpty ?? false) {
            return(false, SignUpValidation.name.rawValue)
            
        }
        else if (txtEmail.text?.isEmpty ?? false) {
            return(false, SignUpValidation.email.rawValue)
            
        } else if (txtPassword.text?.isEmpty ?? false) {
            return(false, SignUpValidation.password.rawValue)
            
        } else if (txtConPassword.text?.isEmpty ?? false) {
            return(false, SignUpValidation.con_Password.rawValue)
            
        } else if (txtConPassword.text != txtPassword.text) {
            return(false, SignUpValidation.passwordMatch.rawValue)
            
        }else if (txtPhone.text?.isEmpty ?? false) {
            return(false, SignUpValidation.phone.rawValue)
            
        } else if (txtPhone.text?.count ?? 0 < 9) {
            return(false, SignUpValidation.phonev1.rawValue)
            
        } else if (txtPhone.text?.count ?? 0 > 10) {
            return(false, SignUpValidation.phonev2.rawValue)
            
        }
        else if !self.isValidEmailAddress(txtEmail.text ?? "") {
            return (false, SignUpValidation.validEmail.rawValue)
            
        }
        return(true, "")
    }
    
}
