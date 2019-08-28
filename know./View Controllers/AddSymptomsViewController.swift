//
//  AddSymptomsViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/28/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class AddSymptomsViewController: UIViewController {

    
    //Properties
    var day: Day?
    
    //Outlets
    
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //Helper Functions
    func saveDay(date: Date) {
        guard let user = UserController.shared.currentUser else { return }
        DayController.shared.saveDay(forUser: user, date: date) { (day) in
            if (day != nil) {
                self.day = day
                print("The Input Day Data was Saved!")
            }
        }
    }
    
    func saveSymptoms(day: Day) {
        FlowController.shared.saveFlowDetails(forDay: day, spotting: <#T##Bool#>, light: <#T##Bool#>, medium: <#T##Bool#>, heavy: <#T##Bool#>) { (success) in
            if success {
                print("The Input Mood Data was Saved!")
            }
        }
        SymptomController.shared.saveSymptoms(forDay: day, headache: <#T##Bool#>, cramping: <#T##Bool#>, backPain: <#T##Bool#>, breastTenderness: <#T##Bool#>, nausea: <#T##Bool#>, fatigue: <#T##Bool#>, insomnia: <#T##Bool#>, acne: <#T##Bool#>) { (success) in
            if success {
                print("The Input Symptom Data was Saved!")
            }
        }
        MoodController.shared.saveMoods(forDay: day, happy: <#T##Bool#>, sensitive: <#T##Bool#>, sad: <#T##Bool#>, depressed: <#T##Bool#>, nervous: <#T##Bool#>, irritated: <#T##Bool#>, content: <#T##Bool#>, moodSwings: <#T##Bool#>, angry: <#T##Bool#>) { (success) in
            if success {
                print("The Input Mood Data was Saved!")
            }
        }
        SexController.shared.saveSexDetails(forDay: day, protected: <#T##Bool#>, sexDrive: <#T##Bool#>, masturbation: <#T##Bool#>) { (success) in
            if success {
                print("The Input Sex Data was Saved!")
            }
        }
        CustomEntryController.shared.saveEntry(forDay: day, text: <#T##String#>) { (success) in
            if success {
                print("The Input Custom Data was Saved!")
            }
        }
    }
}
