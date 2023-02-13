//
//  User+CoreDataProperties.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 11/02/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var mobileNo: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
