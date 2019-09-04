//
//  SettingProfileViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingProfileViewController: UIViewController {
    
    //Properties
    let secondsToYears = 31536000.0
    var birthday = UserController.shared.currentUser?.birthdate
    var updatedBirthday: Date?
    
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
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var authEnableButton: UIButton!
    @IBOutlet weak var authDisableButton: UIButton!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setNavBarView()
        setDelegates()
        tapGestureRecognizer()
        showNotEditing()
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
        self.updatedBirthday = date
        birthdayButton.setTitle(date.stringWith(dateStyle: .medium, timeStyle: .none), for: .normal)
        let age = Int(Date().timeIntervalSince(date) / secondsToYears)
        ageLabel.text = "\(age)"
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if self.editBarButton.title == "Edit" {
            UIView.animate(withDuration: 1) {
                self.showEditing()
            }
            self.loadEditingView()
        } else {
            UIView.animate(withDuration: 1) {
                self.showNotEditing()
            }
            self.loadNotEditingView()
            self.save()
        }
    }
    
    @IBAction func pmsTrueButtonTapped(_ sender: Any) {
        pmsYesButton.isSelected  = true
        pmsNoButton.isSelected = false
    }
    
    @IBAction func pmsFalseButtonTapped(_ sender: Any) {
        pmsNoButton.isSelected = true
        pmsYesButton.isSelected  = false
    }
    
    @IBAction func authEnableButtonTapped(_ sender: Any) {
        authEnableButton.isSelected = true
        authDisableButton.isSelected = false
        DispatchQueue.main.async {
            self.authenticateUser()
        }
    }
    
    @IBAction func authDisableButtonTapped(_ sender: Any) {
        authDisableButton.isSelected = true
        authEnableButton.isSelected = false
    }
    
    //Helper Functions
    //Set Navigation Bar
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
        label.font = UIFont(name: "Nunito-Bold", size: 25)
        navigationItem.titleView = label
    }
    
    //Dismiss Keyboard with tap
    func tapGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Delegates for textfields to dismiss keyboard
    func setDelegates() {
        nameTextField.delegate = self
        ageTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        cycleLengthTextField.delegate = self
        periodLabelTextField.delegate = self
    }
    
    //Set View
    func updateViews() {
        showNotEditing()
        guard let user = UserController.shared.currentUser,
            let name = user.name,
            let birthday = user.birthdate,
            let age = user.age,
            let height = user.height,
            let weight = user.weight,
            let cycleLength = user.cycleLength,
            let periodLength = user.periodLength,
            let pms = user.pms,
            let pmsDuration = user.pmsDuration,
            let authEnabled = user.authEnabled
            else { return }
        let sum = cycleLength.reduce(0, +)
        let average = sum / cycleLength.count
        DispatchQueue.main.async {
            //Label Text
            self.nameLabel.text = name
            self.birthdayLabel.text = birthday.stringWith(dateStyle: .medium, timeStyle: .none)
            self.ageLabel.text = "\(age)"
            self.heightLabel.text = "\(height) cm."
            self.weightLabel.text = "\(weight) lbs."
            self.cycleLengthLabel.text = "\(average) Days"
            self.periodLengthLabel.text = "\(periodLength) Days "
            self.pmsLabel.text = pms ? "Yes (\(pmsDuration) Days)" : "No"
            self.authLabel.text = authEnabled ? "Enabled" : "Disabled"
            //Text Fields Hidden
            self.nameTextField.isHidden = true
            self.birthdayButton.isHidden = true
            self.ageTextField.isHidden = true
            self.heightTextField.isHidden = true
            self.weightTextField.isHidden = true
            self.cycleLengthTextField.isHidden = true
            self.periodLabelTextField.isHidden = true
            self.pmsNoButton.isHidden = true
            self.pmsYesButton.isHidden = true
            self.authEnableButton.isHidden = true
            self.authDisableButton.isHidden = true
        }
    }
    
    func loadEditingView() {
        guard let user = UserController.shared.currentUser,
            let name = user.name,
            let birthday = user.birthdate,
            let height = user.height,
            let weight = user.weight,
            let cycleLength = user.cycleLength,
            let periodLength = user.periodLength
            else { return }
        let sum = cycleLength.reduce(0, +)
        let average = sum / cycleLength.count
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
        authEnableButton.isHidden = false
        authDisableButton.isHidden = false
        //TextField Text
        nameTextField.text = name
        birthdayButton.setTitle(birthday.stringWith(dateStyle: .medium, timeStyle: .none), for: .normal)
        heightTextField.text = "\(height)"
        weightTextField.text = "\(weight)"
        cycleLengthTextField.text = "\(average)"
        periodLabelTextField.text = "\(periodLength)"
        if pmsLabel.text == "No" {
            pmsNoButton.isSelected = true
            pmsYesButton.isSelected = false
        } else {
            pmsYesButton.isSelected = true
            pmsNoButton.isSelected = false
        }
        if authLabel.text == "Enabled" {
            authEnableButton.isSelected = true
            authDisableButton.isSelected = false
        } else {
            authEnableButton.isSelected = false
            authDisableButton.isSelected = true
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
        authLabel.isHidden = true
    }
    
    func showEditing() {
        nameTextField.alpha = 1
        birthdayButton.alpha = 1
        heightTextField.alpha = 1
        weightTextField.alpha = 1
        cycleLengthTextField.alpha = 1
        periodLabelTextField.alpha = 1
        pmsNoButton.alpha = 1
        pmsYesButton.alpha = 1
        authEnableButton.alpha = 1
        authDisableButton.alpha = 1
        nameLabel.alpha = 0
        birthdayLabel.alpha = 0
        heightLabel.alpha = 0
        weightLabel.alpha = 0
        cycleLengthLabel.alpha = 0
        periodLengthLabel.alpha = 0
        pmsLabel.alpha = 0
        authLabel.alpha = 0
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
        authEnableButton.isHidden = true
        authDisableButton.isHidden = true
        //Labels
        nameLabel.isHidden = false
        birthdayLabel.isHidden = false
        ageLabel.isHidden = false
        heightLabel.isHidden = false
        weightLabel.isHidden = false
        cycleLengthLabel.isHidden = false
        periodLengthLabel.isHidden = false
        pmsLabel.isHidden = false
        authLabel.isHidden = false
    }
    
    func showNotEditing() {
        nameTextField.alpha = 0
        birthdayButton.alpha = 0
        heightTextField.alpha = 0
        weightTextField.alpha = 0
        cycleLengthTextField.alpha = 0
        periodLabelTextField.alpha = 0
        pmsNoButton.alpha = 0
        pmsYesButton.alpha = 0
        authEnableButton.alpha = 0
        authDisableButton.alpha = 0
        nameLabel.alpha = 1
        birthdayLabel.alpha = 1
        heightLabel.alpha = 1
        weightLabel.alpha = 1
        cycleLengthLabel.alpha = 1
        periodLengthLabel.alpha = 1
        pmsLabel.alpha = 1
        authLabel.alpha = 1
    }
    
    func save() {
        //Unwrap and set Properties
        guard let user = UserController.shared.currentUser,
            let name = nameTextField.text, name.isEmpty == false,
            let birthday = updatedBirthday ?? birthday,
            let height = Int(heightTextField.text ?? "200"),
            let weight = Int(weightTextField.text ?? "170"),
            let cycleLength = Int(cycleLengthTextField.text ?? "28"),
            let periodLength = Int(periodLabelTextField.text ?? "4"),
            let lastPeriod = user.lastPeriod,
            var pmsDuration = user.pmsDuration,
            var pms = user.pms,
            var authEnabled = user.authEnabled,
            let updateNot = user.upcomingNotificationEnabled,
            let lateNot = user.lateNotificationEnabled
            else { return }
        let menstruates = user.menstruates
        let cycleLengthArray = [cycleLength]
        let cycles = user.cycles
        let age = Int(Date().timeIntervalSince(birthday) / secondsToYears)
        if pmsYesButton.isSelected {
            pms = true
        } else {
            pms = false
            pmsDuration = 0
        }
        if authEnableButton.isSelected {
            authEnabled = true
        } else {
            authEnabled = false
        }
        //Save Updated Info
        UserController.shared.update(user: user, withName: name, menstruates: menstruates, cycles: cycles, birthdate: birthday, age: age, height: height, weight: weight, cycleLength: cycleLengthArray, periodLength: periodLength, pms: pms, pmsDuration: pmsDuration, lastPeriod: lastPeriod, authEnabled: authEnabled, updateNotificationEnabled: updateNot, lateNotificationEnabled: lateNot) { (success) in
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
    
    //Check if authentication is available before enabling
    func authenticateUser() {
        let authContext = LAContext()
        var authError: NSError?
        authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError)
        if authError != nil {
            print("Authentication not available on this device")
            let alertController = UIAlertController (title: "Uh Oh!", message: "Biometric Authentication not supported. Please check settings to allow.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
            authEnableButton.isSelected = false
            authDisableButton.isSelected = true
        } else {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Allow Touch ID") { (success, error) in
                if let error = error {
                    print("Authentication Error")
                    print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                    DispatchQueue.main.async {
                        self.authEnableButton.isSelected = false
                        self.authDisableButton.isSelected = true
                    }
                } else {
                    if success {
                        print("Authentication was successful")
                        let alertController = UIAlertController (title: "Authentication", message: "Use Biometric Authentication to log into app.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Dismiss", style: .default)
                        alertController.addAction(action)
                        self.present(alertController, animated: true)
                    } else {
                        print("Authentication Failed")
                    }
                }
            }
        }
    }
}

//Dismiss Keyboard when screen tapped
extension SettingProfileViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingProfileViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//Dismiss Keyboard when "Enter" tapped
extension SettingProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
