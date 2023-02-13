//
//  ProfileVC.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import UIKit

struct ProfileDataModel {
    let title: String
    let image: UIImage
}
class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    var profileDataArray: [ProfileDataModel] = []
    var image = ["home", "shopping-cart", "favourite", "logout"]
    
    let userName = UserDefaults.standard.value(forKey: UserKeys.name.rawValue) as! String
    let userEmail = UserDefaults.standard.value(forKey: UserKeys.email.rawValue) as! String
    override func viewDidLoad() {
        super.viewDidLoad()
        storedData()
        initialSetUp()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: ProfileTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        lblName.text = userName
        lblEmail.text = userEmail
        
    }
}

// Extension
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    // tableview datasource or delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        let obj = profileDataArray[indexPath.row]
        cell.lblTitle.text = obj.title
        cell.titleIcon.image = obj.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        //Deshboard vc
        case 0:
            self.tabBarController?.selectedIndex = 0
        // Cart vc
        case 1:
            self.tabBarController?.selectedIndex = 1
        // favourite vc
        case 2:
            self.tabBarController?.selectedIndex = 2
            
        // logout
        
        case 3:
            let Alertobj = UIAlertController(title: title, message: "Do you want to Logout", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "YES", style: .default) { (UIAlertAction) in
                
                UserDefaults.standard.setValue("false", forKey: UserKeys.isLoggedIn.rawValue)
                
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            let no = UIAlertAction(title: "NO", style: .cancel) { (UIAlertAction) in
                
            }
            Alertobj.addAction(no)
            Alertobj.addAction(ok)
            self.present(Alertobj, animated: true, completion: nil)
            break;
        default:
            break
        }
    }
    
    func storedData() {
        let createBinObj = ProfileDataModel(title: "Home", image: UIImage(named: "home") ?? UIImage())
        profileDataArray.append(createBinObj)
        
        let binListObj = ProfileDataModel(title: "My cart", image: UIImage(named: "shopping-cart") ?? UIImage())
        profileDataArray.append(binListObj)
        
        let createDriverObj = ProfileDataModel(title: "Favourite", image: UIImage(named: "favourite") ?? UIImage())
        profileDataArray.append(createDriverObj)
        
        let driverListObj = ProfileDataModel(title: "Logout", image: UIImage(named: "logout") ?? UIImage())
        profileDataArray.append(driverListObj)
    }
    func initialSetUp() {
        profileImg.clipsToBounds = true
        profileImg.layer.cornerRadius = 50
       }
}
