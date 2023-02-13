//
//  CartVC.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 11/02/23.
//

import UIKit
import SDWebImage

class CartVC: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    var dbproductHelper: DBHelperProduct = DBHelperProduct()
    var cartArray: [Product] = []
    let userID = UserDefaults.standard.value(forKey: UserKeys.userID.rawValue)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.register(UINib(nibName: CartTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CartTableViewCell.identifier)
        cartArray = dbproductHelper.featchCartList(userid: userID as! Int32)
    }
    override func viewWillAppear(_ animated: Bool) {
        cartArray = dbproductHelper.featchCartList(userid: userID as! Int32)
        cartTableView.reloadData()
    }
    
}

//Extension
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.selectionStyle = .none
        let cartObj = cartArray[indexPath.row]
        cell.lblTitle.text = cartObj.title
        cell.lblCount.text = "\(cartObj.count)"
        let imageUrl = URL(string: cartObj.image ?? "")
        cell.productImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder") )
        
        // minusToCart
        cell.minusToCart = {
            var count = cartObj.count
            if count > 0 {
                count -= 1
            }
            self.dbproductHelper.updateProductCount(id: self.userID as! Int32, index: indexPath.row, count: Int(count), complition: { success in
                
                if success {
                    cartObj.count = count
                    if count == 0 {
                        self.cartArray.remove(at: indexPath.row)
                    }
                    self.cartTableView.reloadData()
                }
                
            })
        }
        
        // plusToCart
        cell.plusToCart = {
            let count = cartObj.count + 1
            
            self.dbproductHelper.updateProductCount(id: self.userID as! Int32 , index: indexPath.row, count: Int(count), complition:{ success in
                if success {
                    cartObj.count = count
                    self.cartTableView.reloadRows(at: [indexPath], with: .automatic)
                }
                
            })
        }
        
        return cell
    }
    
    func initialSetUp() {
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 22
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner,  .layerMinXMaxYCorner]
    }
    
}
