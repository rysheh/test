//
//  AccountsListViewController.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 2/21/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import UIKit

class AccountsListViewController: UIViewController {
    
    var accountsOptions: [String] = ["Sign In/Sign Up", "Settings"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let localCoordinator = LocalDataCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if(localCoordinator.isUserSignedIn()) {
            configureUISignedIn()
        }
    }
    
    @IBAction func returnHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureUISignedIn() {
        DispatchQueue.main.async {
            self.accountsOptions = ["Cook Book", "Shopping Cart", "Challenges", "Accomplishments", "Settings", "Log Out"]
            self.tableView.reloadData()
        }
        
        if localCoordinator.getUser() != nil {
            titleLabel.text = localCoordinator.getUser()!
        }
    }
    
    func logout() {
        print("logging out")
        localCoordinator.logoutUser()
        self.dismiss(animated: true, completion: nil)
    }
}

class OptionsCell: UITableViewCell {
    @IBOutlet weak var optionsLabel: UILabel!
}

extension AccountsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? OptionsCell
    
        let option = accountsOptions[indexPath.row]
        cell?.optionsLabel?.text = option
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = accountsOptions[indexPath.row]
        
        switch option {
        case "Sign In/Sign Up":
            self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Settings":
            print("STUB STUB")
            //self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Cook Book":
            self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Shopping Cart":
            self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Challenges":
            self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Accomplishments":
            self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Settings":
            self.performSegue(withIdentifier: "AccountToDetail", sender: self)
            
        case "Log Out":
            self.logout()
            
        default:
            break
            //do nothing just ignore this
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
