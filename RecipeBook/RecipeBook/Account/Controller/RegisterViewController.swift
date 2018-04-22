//
//  RegisterViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/26/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordConfirmationTextfield: UITextField!
    
    var dc = LocalDataCoordinator()
    var apiCommunication = APICommunication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureUI()
    }
    
    func checkFields() -> Bool {
        if(firstNameTextfield.text != nil &&
           lastNameTextfield.text != nil &&
           emailTextfield.text != nil &&
           passwordTextfield.text != nil &&
           passwordConfirmationTextfield.text != nil) {
            return true
        } else {
            return false
        }
    }
    
    func checkPasswordConfirmation() -> Bool {
        if passwordTextfield.text == passwordConfirmationTextfield.text {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        if(checkFields() && checkPasswordConfirmation()) {
            //Firebase
            if let email = emailTextfield.text, let password = passwordTextfield.text {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        self.performSegue(withIdentifier: "unwindToMainSegue", sender: self)
                    }
                }
                
                //API push new user email to database, returns userId
                apiCommunication.createUser(email: email, completion: { (userID, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        if userID != nil {
                            //Cache user information
                            self.dc.signInUser(email: email, userID: userID!)
                        }
                    }
                })
            }
        }
    }
}

