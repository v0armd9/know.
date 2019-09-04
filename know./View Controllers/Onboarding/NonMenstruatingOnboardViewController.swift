//
//  NonMenstruatingOnboardViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 9/3/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class NonMenstruatingOnboardViewController: UIViewController {

    //Outlets
    @IBOutlet weak var nameQuestionLabel: CustomLabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allowKeyboardDismiss()
    }
    
    //Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, name != "" {
            UserController.shared.currentUser = User(menstruates: false, name: name, age: nil, birthdate: nil, height: nil, weight: nil, cycleLength: nil, periodLength: nil, pms: nil, pmsDuration: nil, lastPeriod: nil)
            self.performSegue(withIdentifier: "welcomeVC", sender: self)
        }
    }
    
    //Helper Function
    func allowKeyboardDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        nameTextField.delegate = self
    }
}

//Dismiss Keyboard when screen tapped
extension NonMenstruatingOnboardViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NonMenstruatingOnboardViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//Dismiss Keyboard when "Enter" tapped
extension NonMenstruatingOnboardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
