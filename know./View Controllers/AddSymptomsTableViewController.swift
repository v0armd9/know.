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
    var viewedDate: Date?
    var customEntryText: String = ""
    
    //Landing Pad
    var dayObject: Day?
    
    //FLOW image name tuples
    let spotting = ("a.spotting", "a.spotting2")
    let light = ("a.light", "a.light2")
    let medium = ("a.medium", "a.medium2")
    let heavy = ("a.heavy", "a.heavy2")
    //SYMP image name tuples
    let acne = ("b.acne", "b.acne2")
    let back = ("b.backpain", "b.backpain2")
    let cramp = ("b.cramp", "b.cramp2")
    let head = ("b.head", "b.head2")
    let insomnia = ("b.insomnia", "b.insomnia2")
    let nausea = ("b.nausea", "b.nausea2")
    let breast = ("b.breast", "b.breast2")
    let fatigue = ("b.fatigue", "b.fatigue2")
    //MOOD image name tuples
    let happy = ("c.happy", "c.happy2")
    let depress = ("c.depress", "c.depress2")
    let irritated = ("c.irritated", "c.irritated2")
    let moodswing = ("c.moodswing", "c.moodswing2")
    let nervous = ("c.nervous", "c.nervous2")
    let sad = ("c.sad", "c.sad2")
    let sensitive = ("c.sensitive", "c.sensitive2")
    let angry = ("c.angry", "c.angry2")
    let content = ("c.content", "c.content2")
    //SEX image name tuples
    let protected = ("d.protected", "d.protected2")
    let unprotected = ("d.unprotected", "d.unprotected2")
    let high = ("d.high", "d.high2")
    let low = ("d.low", "d.low2")
    let mast = ("d.mast", "d.mast2")
    //CUSTOM image name tuple
    let customImage = ("e.custom", "e.custom2")
    
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
    @IBOutlet weak var customTextLabel: UILabel!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarView()
        getFetchedDataToLoadView()
    }
    
    
    //TOGGLE BUTTON PROPERTIES/VIEWS
    //Flow Buttons (Only one may be selected for a day_
    @IBAction func spottingBT(_ sender: Any) {
        if spottingButton.isSelected {
            spottingButton.isSelected = false
        } else {
            spottingButton.isSelected = true
            lightButton.isSelected = false
            mediumButton.isSelected = false
            heavyButton.isSelected = false
        }
        setImageForButton(button: spottingButton, symptom: spotting)
        setImageForButton(button: lightButton, symptom: light)
        setImageForButton(button: mediumButton, symptom: medium)
        setImageForButton(button: heavyButton, symptom: heavy)
    }
    
    @IBAction func lightBT(_ sender: Any) {
        if lightButton.isSelected {
            lightButton.isSelected = false
        } else {
            spottingButton.isSelected = false
            lightButton.isSelected = true
            mediumButton.isSelected = false
            heavyButton.isSelected = false
        }
        setImageForButton(button: spottingButton, symptom: spotting)
        setImageForButton(button: lightButton, symptom: light)
        setImageForButton(button: mediumButton, symptom: medium)
        setImageForButton(button: heavyButton, symptom: heavy)
    }
    
    @IBAction func mediumBT(_ sender: Any) {
        if mediumButton.isSelected {
            mediumButton.isSelected = false
        } else {
            spottingButton.isSelected = false
            lightButton.isSelected = false
            mediumButton.isSelected = true
            heavyButton.isSelected = false
        }
        setImageForButton(button: spottingButton, symptom: spotting)
        setImageForButton(button: lightButton, symptom: light)
        setImageForButton(button: mediumButton, symptom: medium)
        setImageForButton(button: heavyButton, symptom: heavy)
    }
    
    @IBAction func heavyBT(_ sender: Any) {
        if heavyButton.isSelected {
            heavyButton.isSelected = false
        } else {
            spottingButton.isSelected = false
            lightButton.isSelected = false
            mediumButton.isSelected = false
            heavyButton.isSelected = true
        }
        setImageForButton(button: spottingButton, symptom: spotting)
        setImageForButton(button: lightButton, symptom: light)
        setImageForButton(button: mediumButton, symptom: medium)
        setImageForButton(button: heavyButton, symptom: heavy)
    }
    
    //Symptom Buttons (any amount may be selected)
    @IBAction func headacheBT(_ sender: Any) {
        setStatusForButton(button: headacheButton, symptom: head)
    }
    
    @IBAction func crampBT(_ sender: Any) {
        setStatusForButton(button: crampingButton, symptom: cramp)
    }
    
    @IBAction func backpainBT(_ sender: Any) {
        setStatusForButton(button: backacheButton, symptom: back)
    }
    
    @IBAction func breasttendernessBT(_ sender: Any) {
        setStatusForButton(button: tenderButton, symptom: breast)
    }
    
    @IBAction func nauseaBT(_ sender: Any) {
        setStatusForButton(button: nauseaButton, symptom: nausea)
    }
    
    @IBAction func acneBT(_ sender: Any) {
        setStatusForButton(button: acneButton, symptom: acne)
    }
    
    @IBAction func insomniaBT(_ sender: Any) {
        setStatusForButton(button: insomniaButton, symptom: insomnia)
    }
    
    @IBAction func fatigueBT(_ sender: Any) {
        setStatusForButton(button: fatigueButton, symptom: fatigue)
    }
    
    //Mood Buttons (any amount may be selected)
    @IBAction func happyBT(_ sender: Any) {
        setStatusForButton(button: happyButton, symptom: happy)
    }
    
    @IBAction func sadBT(_ sender: Any) {
        setStatusForButton(button: sadButton, symptom: sad)
    }
    
    @IBAction func angryBT(_ sender: Any) {
        setStatusForButton(button: angryButton, symptom: angry)
    }
    
    @IBAction func sensitiveBT(_ sender: Any) {
        setStatusForButton(button: sensitiveButton, symptom: sensitive)
    }
    
    @IBAction func depressedBT(_ sender: Any) {
        setStatusForButton(button: depressedButton, symptom: depress)
    }
    
    @IBAction func nervousBT(_ sender: Any) {
        setStatusForButton(button: nervousButton, symptom:  nervous)
    }
    
    @IBAction func irritatedBT(_ sender: Any) {
        setStatusForButton(button: irritatedButton, symptom: irritated)
    }
    
    @IBAction func contentBT(_ sender: Any) {
        setStatusForButton(button: contentButton, symptom: content)
    }
    
    @IBAction func moodswingBT(_ sender: Any) {
        setStatusForButton(button: moodswingButton, symptom: moodswing)
    }
    
    //Sex Buttons (only one may be selected for protected or sex drive values)
    @IBAction func protectedBT(_ sender: Any) {
        if protectedButton.isSelected {
            protectedButton.isSelected = false
        } else {
            protectedButton.isSelected = true
            unprotectedButton.isSelected = false
        }
        setImageForButton(button: protectedButton, symptom: protected)
        setImageForButton(button: unprotectedButton, symptom: unprotected)
    }
    
    @IBAction func unprotectedBT(_ sender: Any) {
        if unprotectedButton.isSelected {
            unprotectedButton.isSelected = false
        } else {
            protectedButton.isSelected = false
            unprotectedButton.isSelected = true
        }
        setImageForButton(button: protectedButton, symptom: protected)
        setImageForButton(button: unprotectedButton, symptom: unprotected)
    }
    
    @IBAction func highdriveBT(_ sender: Any) {
        if highdriveButton.isSelected {
            highdriveButton.isSelected = false
        } else {
            highdriveButton.isSelected = true
            lowdriveButton.isSelected = false
        }
        setImageForButton(button: highdriveButton, symptom: high)
        setImageForButton(button: lowdriveButton, symptom: low)
    }
    
    @IBAction func lowdriveBT(_ sender: Any) {
        if lowdriveButton.isSelected {
            lowdriveButton.isSelected = false
        } else {
            highdriveButton.isSelected = false
            lowdriveButton.isSelected = true
        }
        setImageForButton(button: highdriveButton, symptom: high)
        setImageForButton(button: lowdriveButton, symptom: low)
    }
    
    @IBAction func masturbationBT(_ sender: Any) {
        setStatusForButton(button: masturbateButton, symptom: mast)
    }
    
    //Custom Entry Button
    @IBAction func customBT(_ sender: Any) {
        self.performSegue(withIdentifier: "toCustomEntryPopup", sender: self)
    }
    
    //Nav bar save button action
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveOrUpdateData()
    }
    
    //NAVIGATION
    //Segue to Popup View (to transfer birthday data)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCustomEntryPopup" {
            let destination = segue.destination as? CustomEntryPopupViewController
            destination?.customEntryText = customEntryText
        }
    }
    
    //Get Data from Popup ViewController for Data Fetch
    @IBAction func unwindToSymptomVC(segue:UIStoryboardSegue) {
        let data = segue.source as? CustomEntryPopupViewController
        guard let text = data?.customEntryText else { return }
        self.customEntryText = text
        if text != "" {
            customButton.isSelected = true
            customTextLabel.text = text
        } else {
            customButton.isSelected = false
            customTextLabel.text = ""
        }
        setImageForButton(button: customButton, symptom: customImage)
    }
    
    //VIEWS
    //Set Navigation View
    func setNavigationBarView() {
        func setNavTitle() {
            let viewedDate = self.viewedDate ?? Date()
            let label = UILabel()
            label.text = viewedDate.stringWith(dateStyle: .long, timeStyle: .none)
            label.textColor = #colorLiteral(red: 0.554766655, green: 0.7184440494, blue: 0.8180738091, alpha: 1)
            label.textAlignment = .center
            label.sizeToFit()
            label.font = UIFont(name: "Nunito-Regular", size: 25)
            navigationItem.titleView = label
        }
    }
    
    //Load correct status/images fpr buttons if on a date with an existing Day object
    func getFetchedDataToLoadView() {
        guard let _ = dayObject,
            let flow = FlowController.shared.flow,
            let symptom = SymptomController.shared.symptoms,
            let mood = MoodController.shared.moods,
            let sex = SexController.shared.sexDetails,
            let custom = CustomEntryController.shared.customEntries
            else { return }
        checkSymptomStatus(flow: flow, symptom: symptom, mood: mood, sex: sex, custom: custom)
    }
    
    //Set Images
    func setImageForButton(button: UIButton, symptom: (unselected: String, selected: String)) {
        button.setImage(UIImage(named: symptom.selected), for: .selected)
        button.setImage(UIImage(named: symptom.unselected), for: .normal)
    }
    
    //Change button status and set image
    func setStatusForButton(button: UIButton, symptom: (unselected: String, selected: String)) {
        if button.isSelected {
            button.isSelected = false
        } else {
            button.isSelected = true
        }
        setImageForButton(button: button, symptom: symptom)
    }
    
    //Check Button status if viewing an already existing Day
    func initialButtonStat(symptom: Bool, button: UIButton, image: (unselected: String, selected: String)) {
        if symptom == true {
            button.isSelected = true
            button.setImage(UIImage(named: image.selected), for: .selected)
        }
    }
    
    //Set existing value properties for buttons
    func checkSymptomStatus(flow: Flow, symptom: Symptom, mood: Mood, sex: Sex, custom: CustomEntry) {
        //Properties for FLOW model object
        initialButtonStat(symptom: flow.spotting, button: spottingButton, image: spotting)
        initialButtonStat(symptom: flow.light, button: lightButton, image: light)
        initialButtonStat(symptom: flow.medium, button: mediumButton, image: medium)
        initialButtonStat(symptom: flow.heavy, button: heavyButton, image: heavy)
        //Properties for SYMPTOM model object
        initialButtonStat(symptom: symptom.headache, button: headacheButton, image: head)
        initialButtonStat(symptom: symptom.cramping, button: crampingButton, image: cramp)
        initialButtonStat(symptom: symptom.backPain, button: backacheButton, image: back)
        initialButtonStat(symptom: symptom.breastTenderness, button: tenderButton, image: breast)
        initialButtonStat(symptom: symptom.nausea, button: nauseaButton, image: nausea)
        initialButtonStat(symptom: symptom.fatigue, button: fatigueButton, image: fatigue)
        initialButtonStat(symptom: symptom.insomnia, button: insomniaButton, image: insomnia)
        initialButtonStat(symptom: symptom.acne, button: acneButton, image: acne)
        //Properties for MOOD model object
        initialButtonStat(symptom: mood.happy, button: happyButton, image: happy)
        initialButtonStat(symptom: mood.sensitive, button: sensitiveButton, image: sensitive)
        initialButtonStat(symptom: mood.sad, button: sadButton, image: sad)
        initialButtonStat(symptom: mood.depressed, button: depressedButton, image: depress)
        initialButtonStat(symptom: mood.nervous, button: nervousButton, image: nervous)
        initialButtonStat(symptom: mood.irritated, button: irritatedButton, image: irritated)
        initialButtonStat(symptom: mood.content, button: contentButton, image: content)
        initialButtonStat(symptom: mood.moodSwings, button: moodswingButton, image: moodswing)
        initialButtonStat(symptom: mood.angry, button: angryButton, image: angry)
        //Properties for SEX model object
        initialButtonStat(symptom: sex.protected, button: protectedButton, image: protected)
        initialButtonStat(symptom: sex.unprotected, button: unprotectedButton, image: unprotected)
        initialButtonStat(symptom: sex.sexDrive, button: highdriveButton, image: high)
        initialButtonStat(symptom: sex.lowDrive, button: lowdriveButton, image: low)
        initialButtonStat(symptom: sex.masturbation, button: masturbateButton, image: mast)
        customTextLabel.text = custom.text
        customEntryText = custom.text
        customButton.isSelected = true
        customButton.setImage(UIImage(named: customImage.1), for: .selected)
    }
    
    //COLLECT DATA
    //Properties for FLOW model object
    func getFlowData(flow: Flow) -> Flow {
        flow.spotting = self.spottingButton.isSelected ? true : false
        flow.light = self.lightButton.isSelected ? true : false
        flow.medium = self.mediumButton.isSelected ? true : false
        flow.heavy = self.heavyButton.isSelected ? true : false
        return flow
    }
    
    //Properties for SYMPTOM model object
    func getSymptomData(symptom: Symptom) -> Symptom {
        symptom.headache = self.headacheButton.isSelected ? true : false
        symptom.cramping = self.crampingButton.isSelected ? true : false
        symptom.backPain = self.backacheButton.isSelected ? true : false
        symptom.breastTenderness = self.tenderButton.isSelected ? true : false
        symptom.nausea = self.nauseaButton.isSelected ? true : false
        symptom.fatigue = self.fatigueButton.isSelected ? true : false
        symptom.insomnia = self.insomniaButton.isSelected ? true : false
        symptom.acne = self.acneButton.isSelected ? true : false
        return symptom
    }
    
    //Properties for MOOD model object
    func getMoodData(mood: Mood) -> Mood {
        mood.happy = self.happyButton.isSelected ? true : false
        mood.sensitive = self.sensitiveButton.isSelected ? true : false
        mood.sad = self.sadButton.isSelected ? true : false
        mood.depressed = self.depressedButton.isSelected ? true : false
        mood.nervous = self.nervousButton.isSelected ? true : false
        mood.irritated = self.irritatedButton.isSelected ? true : false
        mood.content = self.contentButton.isSelected ? true : false
        mood.moodSwings = self.moodswingButton.isSelected ? true : false
        mood.angry = self.angryButton.isSelected ? true : false
        return mood
    }
    
    //Properties for SEX model object
    func getSexData(sex: Sex) -> Sex {
        sex.protected = self.protectedButton.isSelected ? true : false
        sex.unprotected = self.unprotectedButton.isSelected ? true : false
        sex.sexDrive = self.highdriveButton.isSelected ? true : false
        sex.lowDrive = self.lowdriveButton.isSelected ? true : false
        sex.masturbation = self.masturbateButton.isSelected ? true : false
        return sex
    }
    
    //Properties for CUSTOM model object
    func getCustomEntryData(entry: CustomEntry) -> CustomEntry {
        entry.text = self.customEntryText
        return entry
    }
    
    //CRUD
    //Save all Day properties
    func saveSymptoms(day: Day, flow: Flow, symptom: Symptom, mood: Mood, sex: Sex, entry: CustomEntry, completion: @escaping(Bool) -> Void) {
        FlowController.shared.saveFlowDetails(forDay: day, spotting: flow.spotting, light: flow.light, medium: flow.medium, heavy: flow.heavy) { (success) in
            if !success { completion(false); return }
        }
        SymptomController.shared.saveSymptoms(forDay: day, headache: symptom.headache, cramping: symptom.cramping, backPain: symptom.backPain, breastTenderness: symptom.breastTenderness, nausea: symptom.nausea, fatigue: symptom.fatigue, insomnia: symptom.insomnia, acne: symptom.acne) { (success) in
            if !success { completion(false); return }
        }
        MoodController.shared.saveMoods(forDay: day, happy: mood.happy, sensitive: mood.sensitive, sad: mood.sad, depressed: mood.depressed, nervous: mood.nervous, irritated: mood.irritated, content: mood.content, moodSwings: mood.moodSwings, angry: mood.angry) { (success) in
            if !success { completion(false); return }
        }
        SexController.shared.saveSexDetails(forDay: day, protected: sex.protected, unprotected: sex.unprotected, sexDrive: sex.sexDrive, lowDrive: sex.lowDrive, masturbation: sex.masturbation) { (success) in
            if !success { completion(false); return }
        }
        CustomEntryController.shared.saveEntry(forDay: day, text: entry.text) { (success) in
            if !success { completion(false); return }
        }
        completion(true)
    }
    
    //Update all Day properties
    func updateSymptoms(flow: Flow, symptom: Symptom, mood: Mood, sex: Sex, entry: CustomEntry, completion: @escaping(Bool) -> Void) {
        FlowController.shared.update(flow: flow, withSpotting: flow.spotting, light: flow.light, medium: flow.medium, heavy: flow.heavy) { (success) in
            if !success { completion(false); return }
        }
        SymptomController.shared.update(symptom: symptom, withHeadache: symptom.headache, cramping: symptom.cramping, backPain: symptom.backPain, breastTenderness: symptom.breastTenderness, nausea: symptom.nausea, fatigue: symptom.fatigue, insomnia: symptom.insomnia, acne: symptom.acne) { (success) in
            if !success { completion(false); return }
        }
        MoodController.shared.update(mood: mood, withHappy: mood.happy, sensitive: mood.sensitive, sad: mood.sad, depressed: mood.depressed, nervous: mood.nervous, irritated: mood.irritated, content: mood.content, moodSwings: mood.moodSwings, angry: mood.angry) { (success) in
            if !success { completion(false); return }
        }
        SexController.shared.update(sexDetails: sex, withProtected: sex.protected, unprotected: sex.unprotected, sexDrive: sex.sexDrive, lowDrive: sex.lowDrive, masturbation: sex.masturbation) { (success) in
            if !success { completion(false); return }
        }
        CustomEntryController.shared.update(entry: entry, text: entry.text) { (success) in
            if !success { completion(false); return }
        }
        completion(true)
    }
    
    //Save or Update Day depending on if a day already exists or not
    func saveOrUpdateData() {
        guard let user = UserController.shared.currentUser else { return }
        //Update day object if one already exists on the current date
        if dayObject != nil {
            DispatchQueue.main.async {
                guard var flow = FlowController.shared.flow,
                    var symptom = SymptomController.shared.symptoms,
                    var mood = MoodController.shared.moods,
                    var sex = SexController.shared.sexDetails,
                    var custom = CustomEntryController.shared.customEntries
                    else {
                        print("Something went wrong")
                        return
                    }
                flow = self.getFlowData(flow: flow)
                symptom = self.getSymptomData(symptom: symptom)
                mood = self.getMoodData(mood: mood)
                sex = self.getSexData(sex: sex)
                custom = self.getCustomEntryData(entry: custom)
                self.updateSymptoms(flow: flow, symptom: symptom, mood: mood, sex: sex, entry: custom, completion: { (success) in
                    if success {
                        print("Updatetd the input data!")
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("Error updating the input data")
                    }
                })
            }
        //Save new day object if one does not exist on the current date
        } else {
            guard let date = viewedDate?.formattedDate() else { return }
            DayController.shared.saveDay(forUser: user, date: date) { (day) in
                if let day = day {
                    DispatchQueue.main.async {
                        var flow = Flow(day: day)
                        flow = self.getFlowData(flow: flow)
                        var symptom = Symptom(day: day)
                        symptom = self.getSymptomData(symptom: symptom)
                        var mood = Mood(day: day)
                        mood = self.getMoodData(mood: mood)
                        var sex = Sex(day: day)
                        sex = self.getSexData(sex: sex)
                        var customEntry = CustomEntry(day: day, text: "")
                        customEntry = self.getCustomEntryData(entry: customEntry)
                        self.saveSymptoms(day: day, flow: flow, symptom: symptom, mood: mood, sex: sex, entry: customEntry, completion: { (success) in
                            if success {
                                print("Saved the input data!")
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                print("Error saving the input data")
                            }
                        })
                    }
                }
            }
        }
    }
}
