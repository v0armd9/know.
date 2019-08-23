//
//  OnboardWeightViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardWeightViewController: UIViewController {

    //Properties
    var weightPickerData: [Int] = []
    var weight = Int()
    
    //Outlets
    @IBOutlet weak var questionLabel: CustomLabel!
    @IBOutlet weak var pageLabel: CustomLabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var weightLabel: CustomLabel!
    @IBOutlet weak var weightPickerView: UIPickerView!
    @IBOutlet weak var notSureButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weightPickerView.dataSource = self
        weightPickerView.delegate = self
        for n in 50...350 {
            weightPickerData.append(n)
        }
        weightPickerView.selectRow(120, inComponent: 0, animated: true)
    }
    
    //Actions
    @IBAction func skipButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UserController.shared.currentUser?.weight = weight
    }
}

//Custom Picker View Data Source
extension OnboardWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = NSAttributedString(string: "\(weightPickerData[row]) lbs", attributes: [:])
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.weight = weightPickerData[row]
    }
}
