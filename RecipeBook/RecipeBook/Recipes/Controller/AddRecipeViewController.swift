//
//  AddRecipeViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 3/12/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {
    var apiCommunication = APICommunication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiCommunication.createRecipe(completion: { (userID, error) in
            if error != nil {
                print(error!)
            } else {
                //Cache user information
            }
        })
    }
}
