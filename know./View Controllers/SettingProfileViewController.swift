//
//  SettingProfileViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class SettingProfileViewController: UIViewController {
    
    //Properties
    let secondsToYears = 31536000.0
    var birthday = UserController.shared.currentUser?.birthdate
    
    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var cycleLengthLabel: UILabel!
    @IBOutlet weak var cycleLengthTextField: UITextField!
    @IBOutlet weak var periodLengthLabel: UILabel!
    @IBOutlet weak var periodLabelTextField: UITextField!
    @IBOutlet weak var pmsLabel: UILabel!
    @IBOutlet weak var pmsYesButton: UIButton!
    @IBOutlet weak var pmsNoButton: UIButton!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setNavBarView()
    }
    
    //Segue to Popup View (to transfer birthday data)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPopupPickerView" {
            let destination = segue.destination as? PopupPickerViewController
            guard let birthday = UserController.shared.currentUser?.birthdate else { return }
            destination?.birthday = birthday
        }
    }
    
    //Actions
    @IBAction func unwindToSettingProfileVC(segue:UIStoryboardSegue) {
        //Get Data from Popup ViewController for Data Fetch
        let data = segue.source as? PopupPickerViewController
        guard let date = data?.datePickerView.date else { return }
        self.birthday = date
        birthdayButton.setTitle(date.stringWith(dateStyle: .medium, timeStyle: .none), for: .normal)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionCrossDissolve, animations: {
            if self.editBarButton.title == "Edit" {
                self.loadEditingView()
            } else {
                self.loadNotEditingView()
                self.save()
            }
        }, completion: nil)
    }
    
    @IBAction func pmsTrueButtonTapped(_ sender: Any) {
        pmsYesButton.isSelected  = true
        pmsNoButton.isSelected = false
    }
    
    @IBAction func pmsFalseButtonTapped(_ sender: Any) {
        pmsNoButton.isSelected = true
        pmsYesButton.isSelected  = false
    }
    
    //Helper Functions
    func setNavBarView() {
        guard let user = UserController.shared.currentUser,
            let name = user.name
            else { return }
        editBarButton.title = "Edit"
        let label = UILabel()
        label.text = name
        label.textColor = #colorLiteral(red: 0.554766655, green: 0.7184440494, blue: 0.8180738091, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont(name: "Nunito-Regular", size: 30)
        navigationItem.titleView = label
    }
    
    func updateViews() {
        guard let user = UserController.shared.currentUser,
            let name = user.name,
            let birthday = user.birthdate,
            let age = user.age,
            let height = user.height,
            let weight = user.weight,
            let cycleLength = user.cycleLength,
            let periodLength = user.periodLength,
            let pms = user.pms,
            let pmsDuration = user.pmsDuration
            else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.birthdayLabel.text = birthday.stringWith(dateStyle: .medium, timeStyle: .none)
            self.ageLabel.text = "\(age)"
            self.heightLabel.text = "\(height)"
            self.weightLabel.text = "\(weight)"
            self.cycleLengthLabel.text = "\(cycleLength)"
            self.periodLengthLabel.text = "\(periodLength)"
            self.pmsLabel.text = pms ? "Yes (\(pmsDuration) Days)" : "No"
            self.nameTextField.isHidden = true
            self.birthdayButton.isHidden = true
            self.ageTextField.isHidden = true
            self.heightTextField.isHidden = true
            self.weightTextField.isHidden = true
            self.cycleLengthTextField.isHidden = true
            self.periodLabelTextField.isHidden = true
            self.pmsNoButton.isHidden = true
            self.pmsYesButton.isHidden = true
        }
    }
    
    func loadEditingView() {
        guard let birthday = birthday else { return }
        editBarButton.title = "Save"
        //TextFields
        nameTextField.isHidden = false
        birthdayButton.isHidden = false
        heightTextField.isHidden = false
        weightTextField.isHidden = false
        cycleLengthTextField.isHidden = false
        periodLabelTextField.isHidden = false
        pmsNoButton.isHidden = false
        pmsYesButton.isHidden = false
        //TextField Text
        nameTextField.text = nameLabel.text
        birthdayButton.setTitle(birthday.stringWith(dateStyle: .medium, timeStyle: .none), for: .normal)
        ageTextField.text = ageLabel.text
        heightTextField.text = heightLabel.text
        weightTextField.text = weightLabel.text
        cycleLengthTextField.text = cycleLengthLabel.text
        periodLabelTextField.text = periodLengthLabel.text
        if pmsLabel.text == "No" {
            pmsNoButton.isSelected = true
            pmsYesButton.isSelected = false
        } else {
            pmsYesButton.isSelected = true
            pmsNoButton.isSelected = false
        }
        //Labels
        nameLabel.isHidden = true
        birthdayLabel.isHidden = true
        ageLabel.isHidden = false
        heightLabel.isHidden = true
        weightLabel.isHidden = true
        cycleLengthLabel.isHidden = true
        periodLengthLabel.isHidden = true
        pmsLabel.isHidden = true
    }
    
    func loadNotEditingView() {
        //TextFields
        editBarButton.title = "Edit"
        nameTextField.isHidden = true
        birthdayButton.isHidden = true
        heightTextField.isHidden = true
        weightTextField.isHidden = true
        cycleLengthTextField.isHidden = true
        periodLabelTextField.isHidden = true
        pmsNoButton.isHidden = true
        pmsYesButton.isHidden = true
        //Labels
        nameLabel.isHidden = false
        birthdayLabel.isHidden = false
        ageLabel.isHidden = false
        heightLabel.isHidden = false
        weightLabel.isHidden = false
        cycleLengthLabel.isHidden = false
        periodLengthLabel.isHidden = false
        pmsLabel.isHidden = false
    }
    
    func save() {
        //Unwrap and set Properties
        guard let user = UserController.shared.currentUser,
            let name = nameTextField.text, name.isEmpty == false,
            let birthday = birthday,
            let height = Int(heightTextField.text ?? "0"),
            let weight = Int(weightTextField.text ?? "0"),
            let cycleLength = Int(cycleLengthTextField.text ?? "0"),
            let periodLength = Int(periodLabelTextField.text ?? "0"),
            let lastPeriod = user.lastPeriod,
            var pmsDuration = user.pmsDuration,
            var pms = user.pms
            else { return }
        let age = Int(Date().timeIntervalSince(birthday) / secondsToYears)
        if pmsYesButton.isSelected {
            pms = true
        } else {
            pms = false
            pmsDuration = 0
        }
        //Save Updated Info
        UserController.shared.update(user: user, withName: name, age: age, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, pmsDuration: pmsDuration, lastPeriod: lastPeriod) { (success) in
            if success {
                print("Updated User Info")
                DispatchQueue.main.async {
                    self.view.layoutIfNeeded()
                    self.updateViews()
                }
            } else {
                print("Failed to Update User Info")
            }
        }
    }
}

