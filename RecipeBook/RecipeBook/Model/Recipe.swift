//
//  RecipeBook.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 1/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

class Recipe {
   
    var name: String = ""
    var description: String = ""
    var user: String = ""
    var image: UIImage? = nil
//    let ratings: [Int] = []
    var instructions: [Instruction] = []
    
    convenience init(name: String, description: String, user: String, image: UIImage, instructions: [Instruction]) {
        self.init()
        self.name = name
        self.description = description
        self.user = user
        self.image = image
        self.instructions = instructions
    }
    
    static func recipeObject(fromJSON json: [String: Any]) -> Recipe {
        
        let recipe = Recipe()
        
        if let name = json["name"] as? String {
            recipe.name = name
        }
        
        if let description = json["description"] as? String {
            recipe.description = description
        }
        
        if let user = json["user"] as? String {
            recipe.user = user
        }
        
        if let image = json["image"] as? String {
            recipe.image = UIImage(named: image)
        }
        
        if let instructionsObject = json["instructions"] as? [[String : Any]] {
            
            var instructions = [Instruction]()
            
            for instructionObject in instructionsObject {
                
                var instructionTitle = ""
                var instructionImageName = ""
                var instructionImage: UIImage?
                var instructionIngredients = ""
                var instructionTime: Int = 0
                var instructionInfo = ""
                    
                if let title = instructionObject["title"] as? String {
                    instructionTitle = title
                }
                    
                if let imageName = instructionObject["image"] as? String {
                    instructionImageName = imageName
                    instructionImage = UIImage(named: instructionImageName + ".jpg")
                }
                
                if let infoString = instructionObject["info"] as? String {
                    instructionInfo = infoString
                }
                
                if let ingredients = instructionObject["ingredients"] as? String {
                    instructionIngredients = ingredients
                }
                
                if let time = instructionObject["time"] as? String {
                    instructionTime = Int(time)!
                }
                    
                instructions.append(Instruction(title: instructionTitle,
                                                image: instructionImage,
                                                info: instructionInfo,
                                                ingredients: instructionIngredients,
                                                time: instructionTime))
            }
            
            recipe.instructions = instructions 
        }
        
        return recipe
    }
    
}
