//
//  InstructionsViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/10/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak fileprivate var imageView: UIImageView!
    @IBOutlet weak fileprivate var titleLabel: UILabel!
    @IBOutlet weak fileprivate var instructionTitle: UILabel!
    @IBOutlet weak fileprivate var instructionDescription: UITextView!
    @IBOutlet weak fileprivate var instructionIngredients: UITextView!
    @IBOutlet weak var stepNumber: UILabel!
    
    var recipe: Recipe?
    var window: UIWindow?
    var stepCount: Int = 0
    var seconds: Int = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
    //COLOR/BACKGROUND/TEXT
        UINavigationBar.appearance().barTintColor = UIColor(red: 242/255, green: 202/255, blue: 201/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "ADAM.CG PRO", size: 20)!]
    
    //NAVBAR ITEMS
        if(stepCount + 1 == recipe?.instructions.count) {
            let btnDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(InstructionsViewController.finishInstructions))
            self.navigationItem.setRightBarButton(btnDone, animated: false)
        } else {
            let btnNext = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(InstructionsViewController.nextInstruction))
            self.navigationItem.setRightBarButton(btnNext, animated: false)
        }

        let btnPrev = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(InstructionsViewController.prevInstruction))
        self.navigationItem.setLeftBarButton(btnPrev, animated: false)
        
    //TEXTVIEWS/LABELS
        self.stepNumber.text = "\(stepCount + 1)" + "/" + "\(recipe!.instructions.count)"
        self.instructionTitle.text = recipe?.instructions[stepCount].title
        self.instructionDescription.text = recipe?.instructions[stepCount].info
        self.instructionIngredients.text = recipe?.instructions[stepCount].ingredients
        self.imageView.image = recipe?.instructions[stepCount].image
        
    //TIMER
        timer.invalidate()
        seconds = recipe!.instructions[stepCount].time
        self.title = String(seconds)
        runTimer()
    }
    
    @objc func nextInstruction() {
            stepCount = stepCount + 1
            viewDidLoad()
    }
    
    @objc func prevInstruction() {
        if(stepCount == 0) {
            prevViewController()
        }
        else {
            stepCount = stepCount - 1
            viewDidLoad()
        }
    }
    
    @objc func finishInstructions() {
        goToFinish(recipe: recipe!)
    }
    
    func prevViewController() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func goToFinish(recipe: Recipe) {
        let viewController: UIViewController = UIStoryboard(name: "InstructionsView", bundle: nil).instantiateViewController(withIdentifier: "FinishVC") as UIViewController
        
        self.present(viewController, animated: false, completion: nil)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        self.title = String(seconds)
        
        if(seconds == 0) {
            if(stepCount + 1 != recipe?.instructions.count) {
                timer.invalidate()
                nextInstruction()
            }
            else {
                timer.invalidate()
                finishInstructions()
            }
        }
    }
}
