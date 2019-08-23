//
//  OnboardingFinishedViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/23/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardingFinishedViewController: UIViewController {

    //Properties
    
    
    //Outlets
    @IBOutlet weak var welcomeLabel: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Actions
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let user = UserController.shared.currentUser,
        let name = user.name,
        let age = user.age,
        let birthday = user.birthdate,
        let height = user.height,
        let weight = user.weight,
        let cycleLength = user.cycleLength,
        let periodLength = user.periodLength,
        let pms = user.pms,
        let pmsDuration = user.pmsDuration,
        let lastPeriod = user.lastPeriod
            else { return }
        UserController.shared.saveUser(withName: name, age: age, birthdate: birthday, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, pmsDuration: pmsDuration, lastPeriod: lastPeriod) { (success) in
            if success {
                print("Saved \(name)'s User Info!")
            } else {
                print("Error saving user")
                //Error notification for user?
            }
        }
    }
}
