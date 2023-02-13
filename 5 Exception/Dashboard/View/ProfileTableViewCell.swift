//
//  ProfileTableViewCell.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var titleIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
