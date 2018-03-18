//
//  Instruction.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 1/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import Foundation
import UIKit

class Instruction: NSObject {
    let image: UIImage?
    let title: String
    let info: String
    let ingredients: String
    let time: Int
    
    init(title: String, image: UIImage?, info: String, ingredients: String, time: Int) {
        self.title = title
        self.image = image
        self.info = info
        self.ingredients = ingredients
        self.time = time
    }
    
    
}

