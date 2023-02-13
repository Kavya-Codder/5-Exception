//
//  ViewController.swift
//  5 Exceptins
//
//  Created by Kavya Prajapati on 11/02/23.
//

import Foundation
enum UserKeys: String {
    case userID
    case name
    case email
    case mobileNo
    case password
    case isLoggedIn
}
extension UserDefaults {
    class func saveUserVales(user: User?, isLoggedIn: Bool)  {
        UserDefaults.standard.set(user?.id ?? "", forKey: UserKeys.userID.rawValue)
        UserDefaults.standard.set(user?.name ?? "" ,forKey: UserKeys.name.rawValue)
        UserDefaults.standard.set(user?.email ?? "", forKey: UserKeys.email.rawValue)
        UserDefaults.standard.set(user?.mobileNo ?? "" ,forKey: UserKeys.mobileNo.rawValue)
        UserDefaults.standard.set(user?.password ?? "" ,forKey: UserKeys.password.rawValue)
        
        UserDefaults.standard.setValue(isLoggedIn, forKey: UserKeys.isLoggedIn.rawValue)
        
    }
    
}


