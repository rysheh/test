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
    var ratings: Ratings = Ratings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUI() {
        ratingView.settings.fillMode = .half
        ratingView.settings.updateOnTouch = true
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
//        ratingsSlider.value
    
    }
}
