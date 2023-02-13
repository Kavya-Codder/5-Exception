//
//  DeshboardTableViewCell.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import UIKit

class DeshboardTableViewCell: UITableViewCell {
   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    static let identifier = "DeshboardTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSeUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var addToCart:(()->Void)?
    @IBAction func onClickAddToCartBtn(_ sender: Any) {
        addToCart?()
    }
    
    var onClickLikeProduct:(()-> Void)?
    
    @IBAction func onClickLikeBtn(_ sender: Any) {
        onClickLikeProduct?()
    }
    
    func initialSeUp() {
        btnAddToCart.clipsToBounds = true
        btnAddToCart.layer.cornerRadius = 3
        btnAddToCart.layer.shadowColor = UIColor.systemGreen.cgColor
        btnAddToCart.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        btnAddToCart.layer.shadowRadius = 0.5
        btnAddToCart.layer.shadowOpacity = 1.0
        btnAddToCart.layer.masksToBounds = false
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        
        productImg.clipsToBounds = true
        productImg.layer.borderWidth = 0.5
        productImg.layer.borderColor = UIColor(named: "loginButton")?.cgColor
        productImg.layer.cornerRadius = 5
        
    }
    
}
