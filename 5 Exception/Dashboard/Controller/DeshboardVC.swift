//
//  DeshboardVC.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 11/02/23.
//

import UIKit
import SDWebImage
class DeshboardVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var productTableView: UITableView!
    
    var productArray: [Product] = []
    var dbproductHelper: DBHelperProduct = DBHelperProduct()
    let userID = UserDefaults.standard.value(forKey: UserKeys.userID.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(UINib(nibName: DeshboardTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DeshboardTableViewCell.identifier)
        self.tabBarController?.tabBar.isHidden = false
       initialSetUp()
        canFeatchForCoreData()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        productTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

// MARK:- Extension

// tableview delegate or data source method
extension DeshboardVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productTableView.dequeueReusableCell(withIdentifier: DeshboardTableViewCell.identifier, for: indexPath) as! DeshboardTableViewCell
        cell.selectionStyle = .none
        let Obj = productArray[indexPath.row]
        cell.lblTitle.text = Obj.title
        cell.lblPrice.text = "\(Obj.price )"
        let imageUrl = URL(string: Obj.image ?? "")
        cell.productImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        if Obj.isLikeByUser == ((userID) as! Int32) {
            cell.btnLike.setImage(UIImage(named: "FavouriteImg"), for: .normal)
        }
        else {
            cell.btnLike.setImage(UIImage(named: "faviouriteImg"), for: .normal)
        }
        //Like product
        
        cell.onClickLikeProduct = {
            
            self.favourite(productID: Obj.productID, indexPath: indexPath)
        }
        
        if Obj.isAddedToCartByUser == ((userID) as! Int32) {
            cell.btnAddToCart.setTitle("Added to cart", for: .normal)
            
        }
        else {
            cell.btnAddToCart.setTitle("Add to cart", for: .normal)
        }
        
        // add to cart
        cell.addToCart = {
            if Obj.isAddedToCartByUser != ((self.userID) as! Int32) {
                self.dbproductHelper.addToCart(productId: Obj.productID, userID: Int32(self.userID as? Int ?? 0)) { (success) in
                    if success {
                        self.showAlert(title: "success", message: "Product to add cart successfully.", hendler: nil)
                        self.productTableView.reloadData()
                    }
                }
                
            } else {
                self.showAlert(title: "Warning", message: "You have already added to cart.", hendler: nil)
            }
        }
        
        return cell
    }
    
    //MARK:- API CALL
    
    func getProductList() {
        
        let url = URL(string: "https://fakestoreapi.com/products")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let product = try jsonDecoder.decode([ProductBaseModel].self, from: data!)
                
                for detail in product {
                    
                    let dict = ["productID": (detail.id ?? 0), "title": detail.title ?? "", "price": detail.price ?? "", "image": detail.image ?? "", "isAddedToCartByUser":  0, "isLikeByUser": 0, "count": Int32(detail.rating?.count ?? 0)] as [String : Any]
                    
                    self.dbproductHelper.insertPeoduct(object: dict)
                }
                self.productArray = self.dbproductHelper.fetchStoredData()
                DispatchQueue.main.async {
                    
                    self.productTableView.reloadData()
                }
            }
            catch {
                print("Error")
            }
        }
        task.resume()
    }
    
    func canFeatchForCoreData() {
        self.productArray =  self.dbproductHelper.fetchStoredData()
        if self.productArray.isEmpty {
            getProductList()
        }
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
    func initialSetUp() {
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 22
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner,  .layerMinXMaxYCorner]
    }
    func favourite(productID: Int32, indexPath: IndexPath) {
        self.dbproductHelper.likeProduct(id: productID, isLike:  Int32(userID as? Int ?? 0)) { (success) in
            if success {
                self.productTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
