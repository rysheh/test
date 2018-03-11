//
//  RecipeListViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 1/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {

    var recipeDetailViewController: RecipeDetailViewController!
    
    @IBOutlet weak var tableView: UITableView!
    var recipes:[Recipe] = []
    
    let navigationBar = UINavigationBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //when recipesFromAPI completes, return recipe
        
        APICommunication.recipesFromAPI { [weak self] (recipes, error) in
            DispatchQueue.main.async {
                
                guard let recipes = recipes else {
                    print("\(#function) ERROR: \(String(describing: error))")
                    return
                }
                
                self?.recipes = recipes
                self?.tableView.reloadData()
            }
        }
        configureUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecipeDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.recipe = recipes[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func configureUI() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 242/255, green: 202/255, blue: 201/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "ADAM.CG PRO", size: 20)!]
    }
    
    @IBAction func returnHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToShoppingCart(){
        print("SHOPPPING CART")
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeCell
        
        cell.configureForRecipe(recipes[indexPath.row])
        cell.configureUI()
        
        return cell
    }
}


