//
//  Ingredient.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/13/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

struct Ingredient {
    
    var ingredient: String
    var quantity: String
    var measurement: String
    
    init(ingredient: String, quantity: String, measurement: String) {
        self.ingredient = ingredient
        self.quantity = quantity
        self.measurement = measurement
    }
}
