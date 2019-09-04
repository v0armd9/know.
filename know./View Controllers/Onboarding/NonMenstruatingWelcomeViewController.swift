//
//  NonMenstruatingWelcomeViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 9/3/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class NonMenstruatingWelcomeViewController: UIViewController {

    //Outlets
    @IBOutlet weak var welcomeLabel: CustomLabel!
    @IBOutlet weak var continueButton: UIButton!
    
    //Licecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = UserController.shared.currentUser,
            let name = user.name
            else { return }
        welcomeLabel.text = "Nice to meet you \(name)!"
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let user = UserController.shared.currentUser,
            let name = user.name
            else { return }
        let menstruates = user.menstruates
        UserController.shared.saveUser(withName: name, menstruates: menstruates, age: nil, birthdate: nil, height: nil, weight: nil, cycleLength: nil, periodLength: nil, pms: nil, pmsDuration: nil, lastPeriod: nil) { (success) in
            if success {
                print("Saved new user, \(name)!")
                self.performSegue(withIdentifier: "toHomeNavigationVC", sender: self)
            } else {
                print("Error saving user: \(name)")
                //Present error alert
                let alertController = UIAlertController (title: "Uh Oh!", message: "We're sorry, something went wrong. Please come back later.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .default)
                alertController.addAction(action)
            }
        }
    }
}
