//
//  ViewController.swift
//  5 Exceptins
//
//  Created by Kavya Prajapati on 11/02/23.
//
import Foundation
import CoreData
import UIKit

class DBHelper {
    // insert data
    func insertData(object: [String: Any]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // create an entity with user
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        //create new record with this user entity.
        let userManagedObjet = NSManagedObject(entity: entity!, insertInto: context) as! User
        
        // set values for the records
        
        userManagedObjet.id = object["id"] as? Int32 ?? 0
        userManagedObjet.name = object["name"] as? String ?? ""
        userManagedObjet.email = object["email"] as? String ?? ""
        userManagedObjet.password = object["password"] as? String ?? ""
        userManagedObjet.mobileNo = object["mobileNo"] as? String ?? ""
        
        // save the manage object to the core data.
        
        do {
            try context.save()
        } catch (let error){
            print(error.localizedDescription)
        }
        
    }
    
    func CheckForUserEmailAndPasswordMatch (userEmail : String, password : String) ->Bool
    {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let predicate = NSPredicate (format:"email = %@" ,userEmail)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> ( entityName: "User")
        fetchRequest.predicate = predicate
        
        do {
            let fetchRecult =  try context.fetch(fetchRequest)
            if !fetchRecult.isEmpty
            {
                let objectEntity : User = fetchRecult.first as! User
                UserDefaults.saveUserVales(user: objectEntity, isLoggedIn: true)
                if objectEntity.email == userEmail && objectEntity.password == password
                {
                    return true   // Entered Username & password matched
                }
                else
                {
                    return false  //Wrong password/username
                }
            }
            else
            {
                return false
            }
        } catch {
            return false
        }
        
    }
    
}



