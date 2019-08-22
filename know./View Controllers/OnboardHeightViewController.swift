//
//  OnboardHeightViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardHeightViewController: UIViewController {

    //Properties
    var height: Int = 163
    var heightPickerData = [[3, 4, 5, 6, 7],
                            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]]
    
    //Outlets
    @IBOutlet weak var questionLabel: CustomLabel!
    @IBOutlet weak var pageLabel: CustomLabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var feetLabel: CustomLabel!
    @IBOutlet weak var inchesLabel: CustomLabel!
    @IBOutlet weak var heightPickerView: UIPickerView!
    @IBOutlet weak var notSureButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        heightPickerView.delegate = self
        heightPickerView.dataSource = self
        heightPickerView.selectRow(2, inComponent: 0, animated: true)
        heightPickerView.selectRow(0, inComponent:1, animated: true)
    }
    
    
    //Actions
    

    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

//Custom Picker View Data Source
extension OnboardHeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return heightPickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = NSAttributedString(string: String(heightPickerData[component][row]), attributes: [:])
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
