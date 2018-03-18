//
//  SignInViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/26/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("sign in!")
                self.performSegue(withIdentifier: "unwindToMainSegue", sender: self)
            }
        }
        
        let dc = LocalDataCoordinator()
        dc.signInUser(email: emailTextfield.text!, userID: "")
    }
}
