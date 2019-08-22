//
//  OnboardNameViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardNameViewController: UIViewController {

    //Outlets
    @IBOutlet weak var nameQuestionLabel: CustomLabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    //Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, name != "" {
            UserController.shared.currentUser = User(name: name, age: nil, birthdate: nil, height: nil, weight: nil, cycleLength: nil, periodLength: nil, pms: nil, pmsDuration: nil, lastPeriod: nil)
            self.performSegue(withIdentifier: "toWelcomeVC", sender: self)
        }
    }
}

//Dismiss Keyboard when screen tapped
extension OnboardNameViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OnboardNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//Extensions to Dismiss keyboard
extension OnboardNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
