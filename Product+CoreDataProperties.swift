//
//  Product+CoreDataProperties.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productID: Int32
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var image: String?
    @NSManaged public var isAddedToCartByUser: Int32
    @NSManaged public var isLikeByUser: Int32
    @NSManaged public var count: Int32
    

}

extension Product : Identifiable {

}
