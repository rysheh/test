//
//  APICommunication.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 3/2/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import Foundation

class APICommunication {
    
    static let baseURL: String = "http://localhost"

    static func recipesFromAPI(completion: @escaping ([Recipe]?, Error?) ->()) { //returns recipes upon completion
       
        var recipes = [Recipe]()
        
        APICommunication.sendRequest(withURL: URL(string: baseURL + "/recipes")!) { (json, error) in
            
            guard let json = json, error == nil else {
                print("ERROR: \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            guard let recipeObjects = json as? [[String: AnyObject]] else {
                print("ERROR: \(String(describing: error))")
                completion(nil, error)
                return
            }

            for recipeJSON in recipeObjects {
                let recipe = Recipe.recipeObject(fromJSON: recipeJSON)
                recipes.append(recipe)
            }
            
            completion(recipes, nil)
        }
    }
    
    func createUser(email: String, completion: @escaping (String?, Error?) ->()) { //returns userid upon completion
        // create post request
        let url = URL(string: APICommunication.baseURL + "/user")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        
        let jsonRequest: [String: String] = [
            "email": email
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonRequest)
        request.httpBody = jsonData
        
        //take json of user, parse for userObject, return user upon completion
        sendRequest(with: request) {(json, error) in            
            guard let json = json, error == nil else {
                print("ERROR: \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            guard let userObjects = json as? [String: Any] else {
                print("ERROR: \(String(describing: error))")
                completion(nil, error)
                return
            }
    
            //YOU HAVE JSON FOR USER, PARSE OBJECTS AND PUSH IT TO CORE
            
//            userID = User.userObject(fromJSON: userObjects)
            var userID = json["id"]
            
            completion(userID as? String, nil)
        }
    }
    
    //Send request w/ URLRequest, completion returns JSON of user
    func sendRequest(with urlRequest: URLRequest, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            
            guard let content = data,
                let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("\(#function) - ERROR: JSON Failed to parse.")
                    completion(nil, error)
                    return
            }
            
            completion(json, nil)
        }
        
        task.resume()
    }
    
    //Send request for response
    static func sendRequest(withURL url: URL, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let content = data,
                let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [[String: Any]] else {
                    print("\(#function) - ERROR: JSON Failed to parse.")
                    completion(nil, error)
                    return
            }
            
            completion(json, nil)
        }
        
        task.resume()
    }
}
