//
//  TabBarVC.swift
//  Mansarovar
//
//  Created by Kavya Prajapati on 08/12/22.
//

import UIKit

class TabBarVC: UITabBarController {
    
    //var name: AnyObject = 15 as AnyObject
    override func viewDidLoad() {
        super.viewDidLoad()
        initialStUp()
        changeUnSelectedColor()
    }
    
    func initialStUp() {
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 10
        
    }
    
    func changeUnSelectedColor() {
        self.tabBar.unselectedItemTintColor = UIColor.gray
    }
    
    // Tabbar
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
}
