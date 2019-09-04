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
    
    //Save User Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let user = UserController.shared.currentUser,
        let name = user.name
        else { return }
        let menstruates = user.menstruates
        UserController.shared.saveUser(withName: name, menstruates: menstruates, age: nil, birthdate: nil, height: nil, weight: nil, cycleLength: nil, periodLength: nil, pms: nil, pmsDuration: nil, lastPeriod: nil) { (success) in
            if success {
                print("Saved new user, \(name)!")
            }
        }
    }
}
