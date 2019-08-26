//
//  OnboardPeriodLengthViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardPeriodLengthViewController: UIViewController {

    //Properties
    let dayPickerOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    var periodLength: Int = 4
    
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: CustomLabel!
    @IBOutlet weak var pageLabel: CustomLabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var notSureButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        dayPickerView.selectRow(4, inComponent: 0, animated: false)
    }
    
    //Actions
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        
    }

    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UserController.shared.currentUser?.periodLength = periodLength
    }
}

//Custom Picker View Data Source
extension OnboardPeriodLengthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayPickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(dayPickerOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        periodLength = dayPickerOptions[row]
    }
}
