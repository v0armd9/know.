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
    var currentDate: Date?
    var customEntryText: String = ""
    
    //Outlets
    
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarView()
    }
    
    func saveButtonTapped() {
        //Property for DAY model object
        guard let currentDate = currentDate else { return }
        //Properties for FLOW model object
        let flow: Flow
        flow.spotting = spottingButton.isSelected ? true : false
        flow.light = lightButton.isSelected ? true : false
        flow.medium = mediumButton.isSelected ? true : false
        flow.heavy = heavyButton.isSelected ? true : false
        //Properties for SYMPTOM model object
        let symptom: Symptom
        symptom.headache = headacheButton.isSelected ? true : false
        symptom.cramping = crampButton.isSelected ? true : false
        symptom.backPain = backacheButton.isSelected ? true : false
        symptom.breastTenderness = breastButton.isSelected ? true : false
        symptom.nausea = nauseaButton.isSelected ? true : false
        symptom.fatigue = fatigueButton.isSelected ? true : false
        symptom.insomnia = insomniaButton.isSelected ? true : false
        symptom.acne = acneButton.isSelected ? true : false
        //Properties for MOOD model object
        let mood: Mood
        mood.happy = happyButton.isSelected ? true : false
        mood.sensitive = sensitiveButton.isSelected ? true : false
        mood.sad = sadButton.isSelected ? true : false
        mood.depressed = depressedButton.isSelected ? true : false
        mood.nervous = nervousButton.isSelected ? true : false
        mood.irritated = irritatedButton.isSelected ? true : false
        mood.content = contentButton.isSelected ? true : false
        mood.moodSwings = moodswingButton.isSelected ? true : false
        mood.angry = angryButton.isSelected ? true : false
        //Properties for SEX model object
        let sex: Sex
        sex.protected = protectedButton.isSelected ? true : false
        sex.sexDrive = sexdriveButton.isSelected ? true : false
        sex.masturbation = masturbateButton.isSelected ? true : false
        //Properties for CUSTOM model object
        let customEntry: CustomEntry
        customEntry.text = customEntryText
        //Save Functions
        saveDay(date: currentDate) { (day) in
            if let day = day {
                self.saveSymptoms(day: day, flow: flow, symptom: symptom, mood: mood, sex: sex, entry: customEntry, completion: { (success) in
                    if success {
                        //Present popup that says save was successfull and goback to home view controller
                    }
                })
            } else {
                print("Failed to save Day object")
            }
        }
    }
    
    
    
    //Helper Functions
    func setNavigationBarView() {
        func setNavTitle() {
            guard let currentDate = currentDate else { return }
            let label = UILabel()
            label.text = currentDate.stringWith(dateStyle: .long, timeStyle: .none)
            label.textColor = #colorLiteral(red: 0.554766655, green: 0.7184440494, blue: 0.8180738091, alpha: 1)
            label.textAlignment = .center
            label.sizeToFit()
            label.font = UIFont(name: "Nunito-Regular", size: 25)
            navigationItem.titleView = label
        }
    }
    
    func saveDay(date: Date, completion: @escaping(Day?) -> Void) {
        guard let user = UserController.shared.currentUser else { return }
        DayController.shared.saveDay(forUser: user, date: date) { (day) in
            if (day != nil) {
                self.day = day
                completion(day)
                print("The Input Day Data was Saved!")
            }
        }
    }

    func saveSymptoms(day: Day, flow: Flow, symptom: Symptom, mood: Mood, sex: Sex, entry: CustomEntry, completion: @escaping(Bool) -> Void) {
        FlowController.shared.saveFlowDetails(forDay: day, spotting: flow.spotting, light: flow.light, medium: flow.medium, heavy: flow.heavy) { (success) in
            if success {
                print("The Input Mood Data was Saved!")
            } else { completion(false); return }
        }
        SymptomController.shared.saveSymptoms(forDay: day, headache: symptom.headache, cramping: symptom.cramping, backPain: symptom.backPain, breastTenderness: symptom.breastTenderness, nausea: symptom.nausea, fatigue: symptom.fatigue, insomnia: symptom.insomnia, acne: symptom.acne) { (success) in
            if success {
                print("The Input Symptom Data was Saved!")
            } else { completion(false); return }
        }
        MoodController.shared.saveMoods(forDay: day, happy: mood.happy, sensitive: mood.sensitive, sad: mood.sad, depressed: mood.depressed, nervous: mood.nervous, irritated: mood.irritated, content: mood.content, moodSwings: mood.moodSwings, angry: mood.angry) { (success) in
            if success {
                print("The Input Mood Data was Saved!")
            } else { completion(false); return }
        }
        SexController.shared.saveSexDetails(forDay: day, protected: sex.protected, sexDrive: sex.sexDrive, masturbation: sex.masturbation) { (success) in
            if success {
                print("The Input Sex Data was Saved!")
            } else { completion(false); return }
        }
        CustomEntryController.shared.saveEntry(forDay: day, text: entry.text) { (success) in
            if success {
                print("The Input Custom Data was Saved!")
            } else { completion(false); return }
        }
        completion(true)
    }
}
