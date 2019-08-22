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
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        dayPickerView.selectRow(3, inComponent: 0, animated: false)
        dayCountLabel.isHidden = true
        dayPickerView.isHidden = true
    }
    
    //Actions
    @IBAction func skipButtonTapped(_ sender: Any) {
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        dayCountLabel.isHidden = false
        dayPickerView.isHidden = false
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        dayCountLabel.isHidden = true
        dayPickerView.isHidden = true
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
