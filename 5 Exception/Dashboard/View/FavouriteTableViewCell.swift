//
//  FavouriteTableViewCell.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    static let identifier = "FavouriteTableViewCell"
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var lblImage: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
