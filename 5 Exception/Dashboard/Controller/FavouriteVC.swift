//
//  FavouriteVC.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import UIKit
import SDWebImage

class FavouriteVC: UIViewController {
    
    @IBOutlet weak var favouriteTableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    let userID = UserDefaults.standard.value(forKey: UserKeys.userID.rawValue)
    var dbproductHelper: DBHelperProduct = DBHelperProduct()
    var favouriteArray: [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.register(UINib(nibName: FavouriteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        dbproductHelper.getFavouriteProduct(useID: Int32(userID as! Int), complition: { (products) in
            self.favouriteArray = products
            DispatchQueue.main.async {
                self.favouriteTableView.reloadData()
            }
            
        })
                
    }
   
    override func viewWillAppear(_ animated: Bool) {
        dbproductHelper.getFavouriteProduct(useID: Int32(userID as! Int), complition: { (products) in
            self.favouriteArray = products
            DispatchQueue.main.async {
                self.favouriteTableView.reloadData()
            }
            
        })
    }
}

// Extension
extension FavouriteVC: UITableViewDataSource, UITableViewDelegate{
    
    // table view delegate or dataSource methode
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as! FavouriteTableViewCell
        cell.selectionStyle = .none
        let obj = favouriteArray[indexPath.row]
        cell.lblImage.text = obj.title
        let imageUrl = URL(string: obj.image ?? "")
        cell.productImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    
    func initialSetUp() {
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 22
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner,  .layerMinXMaxYCorner]
    }
}
