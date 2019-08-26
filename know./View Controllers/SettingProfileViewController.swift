//
//  SettingProfileViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class SettingProfileViewController: UIViewController {

    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
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
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        guard let user = UserController.shared.currentUser,
        let name = user.name
            else { return }
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
        nameLabel.text = name
        birthdayLabel.text = birthday.stringWith(dateStyle: .medium, timeStyle: .none)
        ageLabel.text = "\(age)"
        heightLabel.text = "\(height)"
        weightLabel.text = "\(weight)"
        cycleLengthLabel.text = "\(cycleLength)"
        periodLengthLabel.text = "\(periodLength)"
        pmsLabel.text = pms ? "Yes (\(pmsDuration) Days)" : "No"
        nameTextField.isHidden = true
        birthdayTextField.isHidden = true
        ageTextField.isHidden = true
        heightTextField.isHidden = true
        weightTextField.isHidden = true
        cycleLengthTextField.isHidden = true
        periodLabelTextField.isHidden = true
        pmsNoButton.isHidden = true
        pmsYesButton.isHidden = true
    }
}
