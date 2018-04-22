//
//  RecipeDetailViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 1/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit
import Cosmos

class RecipeDetailViewController: UIViewController {
    var window: UIWindow?
    
    var recipe: Recipe?
    
    @IBOutlet weak var viewImage: UIImageView?
    @IBOutlet weak var timeLabel: UITextView?
    @IBOutlet weak var ingredientsLabel: UITextView?
    @IBOutlet weak var descriptionLabel: UITextView?
    @IBOutlet weak var userLabel: UITextView?
    @IBOutlet weak var ratingsView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
//        UINavigationBar.appearance().barTintColor = UIColor(red: 242/255, green: 202/255, blue: 201/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "ADAM.CG PRO", size: 30)!]
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addToBook))
        
        viewImage?.image = recipe?.image
        viewImage?.contentMode = .scaleAspectFit
        
        ratingsView.settings.fillMode = .half
        ratingsView.settings.updateOnTouch = false
        timeLabel?.text = getTime()
        
        if let description = recipe?.description {
            descriptionLabel?.text = "\"" + description + "\""
        }
        
        if let ingredients = getIngredients() as? String {
            ingredientsLabel?.text = ingredients
        }
        if(descriptionLabel != nil && ingredientsLabel != nil) {
            adjustUITextViewHeight(arg: descriptionLabel!)
            adjustUITextViewHeight(arg: ingredientsLabel!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if let destinationVC = segue.destination as? InstructionsViewController {
            destinationVC.recipe = recipe
        }
    }
    
    func getTime() -> String {
        var time: Int = 0
        var timeString: String
        
        for i in 0...recipe!.instructions.count-1 {
            time = time + recipe!.instructions[i].time
        }
        
        timeString = String(time) + " min"
        
        return timeString
    }
    
    func getIngredients() -> String {
        var ingredientsList: String = ""
        var ingredientsArray: [Ingredient] = []
        
        for i in 0...recipe!.instructions.count - 1 { //separate all ingredients
            let tempString = recipe!.instructions[i].ingredients
            let stringsArray = tempString.components(separatedBy: ", ")
            
            for i in 0...stringsArray.count - 1 { //separate all components of ingredients
                let componentsArray = stringsArray[i].components(separatedBy: " ")
                
                ingredientsArray.append(Ingredient(ingredient: componentsArray[2], quantity: componentsArray[0], measurement: componentsArray[1]))
            }
        }
        
        for i in 0...ingredientsArray.count - 1 {
            ingredientsList = ingredientsList + ingredientsArray[i].quantity + " " + ingredientsArray[i].measurement + " " + ingredientsArray[i].ingredient + ", "
        }
        
        ingredientsList = "Ingredients: " + ingredientsList
        
        return ingredientsList
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        print("Added to cart")
        //Need to set-up poc api for pushing ingredients up, and fetching in cart
    }
    
    
    func adjustUITextViewHeight(arg : UITextView) //global?
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
}

