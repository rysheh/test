//
//  User.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    @NSManaged var signedIn: Bool
    //    @NSManaged var username: String
    @NSManaged var email: String
    //    @NSManaged var firstName: String
    //    @NSManaged var lastName: String  
    @NSManaged var id: String
    
    convenience init(signedIn: Bool, email: String, id: String) {
        self.init()
        
        self.signedIn = signedIn
        self.email = email
        self.id = id
    }
    
    static func userObject(fromJSON json: [String: Any]) -> User {
        
        let user = User()
        
        if let email = json["email"] as? String {
            user.email = email
        }
        
        if let id = json["id"] as? String {
            user.id = id
        }
        
        return user
    }
}

