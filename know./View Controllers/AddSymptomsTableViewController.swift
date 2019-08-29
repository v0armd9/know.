//
//  AddSymptomsTableViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/29/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class AddSymptomsTableViewController: UITableViewController {

    //Properties
    var currentDate: Date?
    var customEntryText: String = ""
    
    //Outlets
    @IBOutlet weak var flowLabel: CustomLabel!
    @IBOutlet weak var spottingButton: UIButton!
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var heavyButton: UIButton!
    @IBOutlet weak var symptomsLabel: CustomLabel!
    @IBOutlet weak var headacheButton: UIButton!
    @IBOutlet weak var crampingButton: UIButton!
    @IBOutlet weak var backacheButton: UIButton!
    @IBOutlet weak var tenderButton: UIButton!
    @IBOutlet weak var nauseaButton: UIButton!
    @IBOutlet weak var acneButton: UIButton!
    @IBOutlet weak var insomniaButton: UIButton!
    @IBOutlet weak var fatigueButton: UIButton!
    @IBOutlet weak var moodLabel: CustomLabel!
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    @IBOutlet weak var sensitiveButton: UIButton!
    @IBOutlet weak var depressedButton: UIButton!
    @IBOutlet weak var nervousButton: UIButton!
    @IBOutlet weak var irritatedButton: UIButton!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var moodswingButton: UIButton!
    @IBOutlet weak var sexLabel: CustomLabel!
    @IBOutlet weak var protectedButton: UIButton!
    @IBOutlet weak var unprotectedButton: UIButton!
    @IBOutlet weak var highdriveButton: UIButton!
    @IBOutlet weak var lowdriveButton: UIButton!
    @IBOutlet weak var masturbateButton: UIButton!
    @IBOutlet weak var customLabel: CustomLabel!
    @IBOutlet weak var customButton: UIButton!
    
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarView()
    }
    
    //Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveTapped()
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
    
    func saveTapped() {
        //save DAY model object
        guard let currentDate = currentDate?.formattedDate(),
            let user = UserController.shared.currentUser
            else { return }
        DayController.shared.saveDay(forUser: user, date: currentDate) { (day) in
            if let day = day {
                //Properties for FLOW model object
                let flow = Flow(day: day)
                flow.spotting = self.spottingButton.isSelected ? true : false
                flow.light = self.lightButton.isSelected ? true : false
                flow.medium = self.mediumButton.isSelected ? true : false
                flow.heavy = self.heavyButton.isSelected ? true : false
                //Properties for SYMPTOM model object
                let symptom = Symptom(day: day)
                symptom.headache = self.headacheButton.isSelected ? true : false
                symptom.cramping = self.crampingButton.isSelected ? true : false
                symptom.backPain = self.backacheButton.isSelected ? true : false
                symptom.breastTenderness = self.tenderButton.isSelected ? true : false
                symptom.nausea = self.nauseaButton.isSelected ? true : false
                symptom.fatigue = self.fatigueButton.isSelected ? true : false
                symptom.insomnia = self.insomniaButton.isSelected ? true : false
                symptom.acne = self.acneButton.isSelected ? true : false
                //Properties for MOOD model object
                let mood = Mood(day: day)
                mood.happy = self.happyButton.isSelected ? true : false
                mood.sensitive = self.sensitiveButton.isSelected ? true : false
                mood.sad = self.sadButton.isSelected ? true : false
                mood.depressed = self.depressedButton.isSelected ? true : false
                mood.nervous = self.nervousButton.isSelected ? true : false
                mood.irritated = self.irritatedButton.isSelected ? true : false
                mood.content = self.contentButton.isSelected ? true : false
                mood.moodSwings = self.moodswingButton.isSelected ? true : false
                mood.angry = self.angryButton.isSelected ? true : false
                //Properties for SEX model object
                let sex = Sex(day: day)
                sex.protected = self.protectedButton.isSelected ? true : false
                sex.sexDrive = self.highdriveButton.isSelected ? true : false
                sex.masturbation = self.masturbateButton.isSelected ? true : false
                //Properties for CUSTOM model object
                let customEntry = CustomEntry(day: day, text: "")
                //                    customEntry.text = customEntryText
                //Save all model objects
                self.saveSymptoms(day: day, flow: flow, symptom: symptom, mood: mood, sex: sex, entry: customEntry, completion: { (success) in
                    if success {
                        //Present popup that says save was successfull and goback to home view controller
                    } else {
                        print("Error saving the input data")
                    }
                })
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
