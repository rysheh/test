//
//  RecipeCell.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/13/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    
    func configureForRecipe(_ recipe: Recipe) {
        recipeName.text = recipe.name
        recipeImageView.image = recipe.image
        recipeImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    }
    
    func configureUI() {
        recipeName.font = UIFont(name: "ADAM.CG PRO", size: 50)
        recipeName.lineBreakMode = .byWordWrapping
        recipeName.numberOfLines = 2
        
        recipeImageView.layer.masksToBounds = false
    }
}

