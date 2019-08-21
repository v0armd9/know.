//
//  OnboardCycleLengthViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardCycleLengthViewController: UIViewController {

    //Properties
    let cycleLengthOptions = [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
    var cycleLength = 28
    
    //Outlets
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
        dayPickerView.selectRow(8, inComponent: 0, animated: false)
    }
    
    //Actions
    @IBAction func skipButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    

    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

//Custom Picker View Data Source
extension OnboardCycleLengthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cycleLengthOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(cycleLengthOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cycleLength = cycleLengthOptions[row]
    }
}
