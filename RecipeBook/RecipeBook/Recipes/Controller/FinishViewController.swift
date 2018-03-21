//
//  FinishViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit
import Cosmos

class FinishViewController: UIViewController {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var commentsTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUI() {
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
    
    }
}
