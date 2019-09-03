//
//  OnboardPMSViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardPMSViewController: UIViewController {

    //Properties
    let dayPickerOptions = [1, 2, 3, 4, 5, 6, 7]
    var experiencesPms = false
    var pmsLength = 4
    
    //Outlets
    @IBOutlet weak var questionLabel: CustomLabel!
    @IBOutlet weak var pageLabel: CustomLabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var notSureButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var viewBar: UIView!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        dayPickerView.selectRow(3, inComponent: 0, animated: false)
        dayCountLabel.isHidden = true
        dayPickerView.isHidden = true
        viewBar.isHidden = true
        dayCountLabel.alpha = 0
        dayPickerView.alpha = 0
        viewBar.alpha = 0
    }
    
    //Actions
    @IBAction func yesButtonTapped(_ sender: Any) {
        experiencesPms = true
        UIView.animate(withDuration: 0.5) {
            self.yesButton.isSelected = true
            self.noButton.isSelected = false
            self.dayCountLabel.isHidden = false
            self.dayPickerView.isHidden = false
            self.viewBar.isHidden = false
            self.dayCountLabel.alpha = 1
            self.dayPickerView.alpha = 1
            self.viewBar.alpha = 1
            self.setButtonViews()
        }
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        experiencesPms = false
        UIView.animate(withDuration: 1) {
            self.yesButton.isSelected = false
            self.noButton.isSelected = true
            self.dayCountLabel.alpha = 0
            self.dayPickerView.alpha = 0
            self.viewBar.alpha = 0
            self.dayCountLabel.isHidden = true
            self.dayPickerView.isHidden = true
            self.viewBar.isHidden = true
            self.setButtonViews()
        }
    }
    
    //Set views Helper Function
    func setButtonViews() {
        yesButton.setImage(UIImage(named: "yes"), for: .normal)
        yesButton.setImage(UIImage(named: "yesActive"), for: .selected)
        noButton.setImage(UIImage(named: "no"), for: .normal)
        noButton.setImage(UIImage(named: "noActive"), for: .selected)
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if experiencesPms == true {
            UserController.shared.currentUser?.pms = true
            UserController.shared.currentUser?.pmsDuration = pmsLength
        } else {
            UserController.shared.currentUser?.pms = false
            UserController.shared.currentUser?.pmsDuration = 0
        }
    }
}

//Custom Picker View Data Source
extension OnboardPMSViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayPickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = NSAttributedString(string: String(dayPickerOptions[row]), attributes: [:])
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pmsLength = dayPickerOptions[row]
    }
}
