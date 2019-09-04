//
//  OnboardingFinishedViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/23/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit
import CloudKit

class OnboardingFinishedViewController: UIViewController {

    //Outlets
    @IBOutlet weak var welcomeLabel: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let menstruates = user.menstruates
        let cycleLengthInt = cycleLength.first
        //Create new user with the input info from onboarding
        UserController.shared.saveUser(withName: name, menstruates: menstruates, age: age, birthdate: birthday, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, pmsDuration: pmsDuration, lastPeriod: lastPeriod) { (success) in
            if success {
                print("Saved \(name)'s User Info!")
                guard let user = UserController.shared.currentUser else {return}
                //Create the first cycle
                self.createFirstCycle(user: user, periodLength: periodLength, cycleLength: cycleLengthInt!, startDate: lastPeriod)
            } else {
                print("Error saving user")
            }
        }
    }
    
    //Create the first cycle using onboarding data
    func createFirstCycle(user: User, periodLength: Int, cycleLength: Int, startDate: Date) {
        let startDate = startDate.formattedDate()
        let periodEndDate = Calendar.current.date(byAdding: .day, value: periodLength-1, to: startDate)!
        let cycleEndDate = Calendar.current.date(byAdding: .day, value: cycleLength-1, to: startDate)!
        CycleController.shared.saveCycle(forUser: user, cycleStart: startDate, periodEnd: periodEndDate, cycleEnd: cycleEndDate) { (cycle) in
            if let cycle = cycle {
                user.cycles.append(cycle)
            }
        }
    }
}
