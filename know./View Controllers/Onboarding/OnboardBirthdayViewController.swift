//
//  OnboardBirthdayViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardBirthdayViewController: UIViewController {

    //Properties
    var defaultDate = Date()
    var birthday = Date()
    var age = Int()
    let secondsToYears = 31536000.0
    
    //Outlets
    @IBOutlet weak var questionLabel: CustomLabel!
    @IBOutlet weak var pageLabel: CustomLabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var notSureButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultDate()
        datePickerView.setDate(defaultDate, animated: true)
    }
    
    func setDefaultDate() {
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = NSDateComponents()
        components.year = 1990
        components.month = 1
        components.day = 1
        let defaultDate: NSDate = calendar.date(from: components as DateComponents)! as NSDate
        self.defaultDate = defaultDate as Date
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        birthday = datePickerView.date
        age = Int(Date().timeIntervalSince(birthday) / secondsToYears)
        UserController.shared.currentUser?.age = age
        UserController.shared.currentUser?.birthdate = birthday
    }
}
