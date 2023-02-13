//
//  DBHelperProduct.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 12/02/23.
//

import Foundation
import CoreData
import UIKit

class DBHelperProduct {
    // insert data
    func insertPeoduct(object: [String: Any]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // create an entity with user
        
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        
        //create new record with this user entity.
        let productManagedObjet = NSManagedObject(entity: entity!, insertInto: context) as! Product
        
        // set values for the records
        
        productManagedObjet.productID = Int32(object["productID"] as? Int ?? 0)
        productManagedObjet.title = object["title"] as? String ?? ""
        productManagedObjet.price = object["price"] as? Double ?? 0
        productManagedObjet.isAddedToCartByUser = object["isAddedToCartByUser"] as? Int32 ?? 0
        productManagedObjet.isLikeByUser = object["isLikeByUser"] as? Int32 ?? 0
        productManagedObjet.image = object["image"] as? String ?? ""
        productManagedObjet.count = object["count"] as? Int32 ?? 0
        
        // save the manage object to the core data.
        
        do {
            try context.save()
        } catch (let error){
            print(error.localizedDescription)
        }
    }
    
    // featch stored data
    func fetchStoredData() -> [Product] {
        var productArray: [Product] = []
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            let fetchedRequest = try context.fetch(request) as! [Product]
            productArray = fetchedRequest
        } catch (let error) {
            print(error.localizedDescription)
        }
        return productArray
    }
    
    func featchCartList (userid : Int32) -> [Product]
    {
        var cartArray: [Product] = []
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let predicate = NSPredicate (format: "isAddedToCartByUser == %@", "\(userid)")
        let fetchRequest = NSFetchRequest<Product> ( entityName: "Product")
        //   fetchRequest.predicate = predicate
        fetchRequest.predicate = predicate
        
        do
        {
            let results = try context.fetch(fetchRequest)
            cartArray = results
            } catch(let error) {
            print(error.localizedDescription)
        }
        return cartArray
    }
    
    func updateProductCount(id: Int32, index: Int, count: Int, complition: @escaping(Bool) -> Void) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Product")
        let predicate = NSPredicate(format: "isAddedToCartByUser == %@", "\(id)")
        featchRequest.predicate = predicate
        do {
            let results = try context.fetch(featchRequest)
            if !results.isEmpty {
                let obj = results.first as! NSManagedObject
                if count > 0 {
                    obj.setValue(count, forKey: "count")
                } else {
                    obj.setValue(0, forKey: "isAddedToCartByUser")
                }
            }
            try context.save()
            complition(true)
        } catch {
            complition(false)
            print(error.localizedDescription)
        }
    }
    
    func likeProduct(id: Int32, isLike: Int32, complition: @escaping(Bool) -> Void) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Product")
        let predicate = NSPredicate(format: "productID == %@", "\(id)")
        
        featchRequest.predicate = predicate
        do {
            let results = try context.fetch(featchRequest)
            if !results.isEmpty {
                
                let obj = results.first as! NSManagedObject
                if (obj as! Product).isLikeByUser != 0 {
                    obj.setValue(0, forKey: "isLikeByUser")
                } else {
                    obj.setValue(isLike, forKey: "isLikeByUser")
                }
                
            }
             try context.save()
            complition(true)
        } catch {
            complition(false)
            print(error.localizedDescription)
        }
    }
    
    func addToCart(productId: Int32, userID: Int32, complition: @escaping(Bool) -> Void) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Product")
        let predicate = NSPredicate(format: "productID == %@", "\(productId)")
        
        featchRequest.predicate = predicate
        do {
            let results = try context.fetch(featchRequest)
            if !results.isEmpty {
                
                let obj = results.first as! NSManagedObject
                obj.setValue(userID, forKey: "isAddedToCartByUser")
                obj.setValue(1, forKey: "count")
                
            }
           try context.save()
            complition(true)
        } catch {
            complition(false)
            print(error.localizedDescription)
        }
    }
    
    func getFavouriteProduct(useID: Int32, complition: @escaping([Product]) -> Void) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<Product> (entityName: "Product")
        let predicate = NSPredicate(format: "isLikeByUser == %@", "\(useID)")
        
        featchRequest.predicate = predicate
        do {
            let results = try context.fetch(featchRequest)
             complition(results)
        } catch {
            complition([])
            print(error.localizedDescription)
        }
    }
    
}

