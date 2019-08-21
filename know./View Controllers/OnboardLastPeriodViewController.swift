//
//  OnboardLastPeriodViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardLastPeriodViewController: UIViewController {

    //Properties
    var lastPeriod = Date()

    //Outlets
    @IBOutlet weak var questionLabel: CustomLabel!
    @IBOutlet weak var pageLabel: CustomLabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var notSureButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
