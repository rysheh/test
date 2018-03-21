//
//  LocalDataCoordinator.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 3/4/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocalDataCoordinator {
    let container = NSPersistentContainer(name: "RecipeBook")
    
    func isUserSignedIn() -> Bool {
        let managedContext = container.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for item in fetchedResults {
                return (item.value(forKey: "signedIn") as? Bool)!
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return false
    }
    
    func signInUser(email: String, userID: String) {
        let managedContext = container.viewContext
        let description = NSEntityDescription.entity(forEntityName: "\(User.self)", in: managedContext)
        
        //cache user
        let userMO = User(entity: description!, insertInto: managedContext)
        userMO.signedIn = true
        userMO.email = email
        userMO.id = userID
    }
    
    func getUser() -> String? {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        let managedContext = container.viewContext
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for item in fetchedResults {
                return item.value(forKey: "email") as? String
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return "nil"
    }
    
    func logoutUser() {
        let managedContext = container.viewContext
        let description = NSEntityDescription.entity(forEntityName: "\(User.self)", in: managedContext)
        let userMO = User(entity: description!, insertInto: managedContext)
        
        userMO.signedIn = false
        userMO.email = "nil"
        userMO.id = ""
    }
}
