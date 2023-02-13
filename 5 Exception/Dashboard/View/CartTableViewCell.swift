//
//  CartTableViewCell.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    static let identifier = "CartTableViewCell"
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnMinus: UIButton!
    
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var btnPlus: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        initialSetUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var minusToCart: (() -> Void)?
    @IBAction func onClickMinusBtn(_ sender: Any) {
        minusToCart?()
    }
    var plusToCart: (() -> Void)?
    @IBAction func onClickPlusBtn(_ sender: Any) {
        plusToCart?()
    }
    
    func initialSetUp() {
        viewContainer.clipsToBounds = true
        viewContainer.layer.cornerRadius = 10
        
        productImg.clipsToBounds = true
        productImg.layer.cornerRadius = 5
        productImg.layer.borderWidth = 0.5
        productImg.layer.borderColor = UIColor(named: "loginButton")?.cgColor
        
    }
}
