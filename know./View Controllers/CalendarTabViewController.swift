//
//  CalendarTabViewController.swift
//  know.
//
//  Created by Darin Armstrong on 8/27/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class CalendarTabViewController: UIViewController {

    var buttons: [UIButton] = []
    var classArray: [Button] = []
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var symptomData: [String] = ["No Symptoms Logged"]
    
    var years: [Int] = []
    
    var selectedMonth: Int?
    var selectedYear: Int?
    
    var selectedDate: Date = Date().formattedDate()
    
    var user = UserController.shared.currentUser
    
    var periods: [DateInterval] = []
    
    var dayToDisplay: Day?
    
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var lastRow: UIStackView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    @IBOutlet weak var buttonTen: UIButton!
    @IBOutlet weak var buttonEleven: UIButton!
    @IBOutlet weak var buttonTwelve: UIButton!
    @IBOutlet weak var buttonThirteen: UIButton!
    @IBOutlet weak var buttonFourteen: UIButton!
    @IBOutlet weak var buttonFifteen: UIButton!
    @IBOutlet weak var buttonSixteen: UIButton!
    @IBOutlet weak var buttonSeventeen: UIButton!
    @IBOutlet weak var buttonEighteen: UIButton!
    @IBOutlet weak var buttonNineteen: UIButton!
    @IBOutlet weak var buttonTwenty: UIButton!
    @IBOutlet weak var buttonTwentyOne: UIButton!
    @IBOutlet weak var buttonTwentyTwo: UIButton!
    @IBOutlet weak var buttonTwentyThree: UIButton!
    @IBOutlet weak var buttonTwentyFour: UIButton!
    @IBOutlet weak var buttonTwentyFive: UIButton!
    @IBOutlet weak var buttonTwentySix: UIButton!
    @IBOutlet weak var buttonTwentySeven: UIButton!
    @IBOutlet weak var buttonTwentyEight: UIButton!
    @IBOutlet weak var buttonTwentyNine: UIButton!
    @IBOutlet weak var buttonThirty: UIButton!
    @IBOutlet weak var buttonThirtyOne: UIButton!
    @IBOutlet weak var buttonThirtyTwo: UIButton!
    @IBOutlet weak var buttonThirtyThree: UIButton!
    @IBOutlet weak var buttonThirtyFour: UIButton!
    @IBOutlet weak var buttonThirtyFive: UIButton!
    @IBOutlet weak var buttonThirtySix: UIButton!
    @IBOutlet weak var buttonThirtySeven: UIButton!
    @IBOutlet weak var buttonThirtyEight: UIButton!
    @IBOutlet weak var buttonThirtyNine: UIButton!
    @IBOutlet weak var buttonForty: UIButton!
    @IBOutlet weak var buttonFortyOne: UIButton!
    @IBOutlet weak var buttonFortyTwo: UIButton!
    @IBOutlet weak var customPicker: UIPickerView!
    @IBOutlet weak var symptomCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        for number in 2014...2200 {
            years.append(number)
        }
        let startDate = getStartDate(date: selectedDate)
        buttons = [
            buttonOne,
            buttonTwo,
            buttonThree,
            buttonFour,
            buttonFive,
            buttonSix,
            buttonSeven,
            buttonEight,
            buttonNine,
            buttonTen,
            buttonEleven,
            buttonTwelve,
            buttonThirteen,
            buttonFourteen,
            buttonFifteen,
            buttonSixteen,
            buttonSeventeen,
            buttonEighteen,
            buttonNineteen,
            buttonTwenty,
            buttonTwentyOne,
            buttonTwentyTwo,
            buttonTwentyThree,
            buttonTwentyFour,
            buttonTwentyFive,
            buttonTwentySix,
            buttonTwentySeven,
            buttonTwentyEight,
            buttonTwentyNine,
            buttonThirty,
            buttonThirtyOne,
            buttonThirtyTwo,
            buttonThirtyThree,
            buttonThirtyFour,
            buttonThirtyFive,
            buttonThirtySix,
            buttonThirtySeven,
            buttonThirtyEight,
            buttonThirtyNine,
            buttonForty,
            buttonFortyOne,
            buttonFortyTwo
        ]
        setButtons(date: startDate)
        symptomCollectionView.delegate = self
        symptomCollectionView.dataSource = self
        customPicker.delegate = self
        customPicker.dataSource = self
        let currentMonth = Calendar.current.component(.month, from: selectedDate)
        let currentYear = Calendar.current.component(.year, from: selectedDate)
        customPicker.selectRow(currentMonth - 1, inComponent: 0, animated: false)
        customPicker.selectRow(currentYear - 2014, inComponent: 1, animated: false)
        customPicker.reloadAllComponents()
        selectedDateLabel.text = "   \(selectedDate.stringWith(dateStyle: .medium, timeStyle: .none))"
        if let user = user {
            DayController.shared.fetchSingleDay(forUser: user, andDate: selectedDate) { (day) in
                if let day = day {
                    self.fetchSymptoms(day: day, completion: { (success) in
                        if success {
                            self.convertSymptomsToString(day: day)
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func addSymptomTapped(_ sender: UIButton) {
        if selectedDate > Date() {
            performSegue(withIdentifier: "toConfirmPopupVC", sender: self)
        } else {
            performSegue(withIdentifier: "toSymptomVC", sender: self)
        }
    }
    
    
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        let button = classArray[0]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        let button = classArray[1]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThreeTapped(_ sender: UIButton) {
        let button = classArray[2]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFourTapped(_ sender: UIButton) {
        let button = classArray[3]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFiveTapped(_ sender: UIButton) {
        let button = classArray[4]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonSixTapped(_ sender: Any) {
        let button = classArray[5]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonSevenTapped(_ sender: UIButton) {
        let button = classArray[6]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonEightTapped(_ sender: UIButton) {
        let button = classArray[7]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonNineTapped(_ sender: UIButton) {
        let button = classArray[8]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTenTapped(_ sender: UIButton) {
        let button = classArray[9]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonElevenTapped(_ sender: UIButton) {
        let button = classArray[10]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwelveTapped(_ sender: UIButton) {
        let button = classArray[11]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirteenTapped(_ sender: UIButton) {
        let button = classArray[12]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFourteenTapped(_ sender: UIButton) {
        let button = classArray[13]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFifteenTapped(_ sender: UIButton) {
        let button = classArray[14]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonSixteenTapped(_ sender: UIButton) {
        let button = classArray[15]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonSeventeenTapped(_ sender: UIButton) {
        let button = classArray[16]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonEighteenTapped(_ sender: UIButton) {
        let button = classArray[17]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonNineteenTapped(_ sender: UIButton) {
        let button = classArray[18]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyTapped(_ sender: UIButton) {
        let button = classArray[19]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyOneTapped(_ sender: UIButton) {
        let button = classArray[20]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyTwoTapped(_ sender: UIButton) {
        let button = classArray[21]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyThreeTapped(_ sender: UIButton) {
        let button = classArray[22]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyFourTapped(_ sender: UIButton) {
        let button = classArray[23]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyFiveTapped(_ sender: UIButton) {
        let button = classArray[24]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentySixTapped(_ sender: UIButton) {
        let button = classArray[25]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentySevenTapped(_ sender: UIButton) {
        let button = classArray[26]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyEightTapped(_ sender: UIButton) {
        let button = classArray[27]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonTwentyNineTapped(_ sender: UIButton) {
        let button = classArray[28]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyTapped(_ sender: UIButton) {
        let button = classArray[29]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyOneTapped(_ sender: UIButton) {
        let button = classArray[30]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyTwoTapped(_ sender: UIButton) {
        let button = classArray[31]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyThreeTapped(_ sender: UIButton) {
        let button = classArray[32]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyFourTapped(_ sender: UIButton) {
        let button = classArray[33]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyFiveTapped(_ sender: UIButton) {
        let button = classArray[34]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtySixTapped(_ sender: UIButton) {
        let button = classArray[35]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtySevenTapped(_ sender: UIButton) {
        let button = classArray[36]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyEightTapped(_ sender: UIButton) {
        let button = classArray[37]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonThirtyNineTapped(_ sender: UIButton) {
        let button = classArray[38]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFortyTapped(_ sender: UIButton) {
        let button = classArray[39]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFortyOneTapped(_ sender: UIButton) {
        let button = classArray[40]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    @IBAction func buttonFortyTwoTapped(_ sender: UIButton) {
        let button = classArray[41]
        selectedDateLabel.text = "   \(button.date.stringWith(dateStyle: .medium, timeStyle: .none))"
        changeDate(button: button)
        symptomData = ["No Symptoms Logged"]
        symptomCollectionView.reloadData()
        guard let day = button.day else {return}
        fetchSymptoms(day: day) { (success) in
            if success {
                self.convertSymptomsToString(day: day)
            }
        }
    }
    
    class Button {
        let date: Date
        let button: UIButton
        var day: Day?
        
        init(date: Date, button: UIButton, day: Day?) {
            self.date = date
            self.button = button
            self.day = day
        }
    }
    
    func getStartDate(date: Date) -> Date {
        var startDate: Date
        let month = Calendar.current.component(.month, from: date)
        selectedMonth = month
        let year = Calendar.current.component(.year, from: date)
        selectedYear = year
        let dateComponents = DateComponents(calendar: Calendar.current, year: year, month: month, day: 1)
        let firstOfMonth = Calendar.current.date(from: dateComponents)!
        let weekDay = Calendar.current.component(.weekday, from: firstOfMonth)
        let daysToSubtract = weekDay - 1
        startDate = Calendar.current.date(byAdding: .day, value: -daysToSubtract, to: firstOfMonth)!
        print(startDate)
        return startDate
    }
    
    func setButtons(date: Date) {
        var date = date.formattedDate()
        var classButtons: [Button] = []
        for button in buttons {
            classButtons.append(Button(date: date, button: button, day: nil))
            let dayNumber = Calendar.current.dateComponents([Calendar.Component.day], from: date).day!
            let buttonMonth = Calendar.current.component(.month, from: date)
            UIView.performWithoutAnimation {
                if selectedMonth != buttonMonth {
                    let buttonTitle = NSAttributedString(string: String(dayNumber), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
                    button.setAttributedTitle(buttonTitle, for: .normal)
                    
                } else {
                    let buttonTitle = NSAttributedString(string: String(dayNumber), attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#96B6CE")])
                    button.setAttributedTitle(buttonTitle, for: .normal)
                }
            }
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        classArray = classButtons
        DispatchQueue.main.async {
            self.setUpMonthView()
            self.setUpDay()
        }
    }
    
    func setUpDay() {
        guard let user = self.user else {return}
        for button in classArray {
            DayController.shared.fetchSingleDay(forUser: user, andDate: button.date.formattedDate()) { (day) in
                if let day = day {
                    button.day = day
                }
            }
            displayPeriod(button: button, user: user)
        }
    }
    
    func setUpMonthView() {
        let selectedMonth = Calendar.current.component(.month, from: selectedDate)
        let lastRowMonth = Calendar.current.component(.month, from: classArray[35].date)
        if lastRowMonth != selectedMonth {
            self.lastRow.isHidden = true
        } else {
            self.lastRow.isHidden = false
        }
    }
    
    func displayPeriod(button: Button) {
        for period in periods {
            if period.start == button.date {
                button.button.setBackgroundImage(#imageLiteral(resourceName: "periodStartBackground"), for: .normal)
            } else if period.end == button.date {
                button.button.setBackgroundImage(#imageLiteral(resourceName: "periodEndBackground"), for: .normal)
            } else if period.contains(button.date) {
                button.button.setBackgroundImage(#imageLiteral(resourceName: "periodMidBackground"), for: .normal)
            } else {
                button.button.setBackgroundImage(nil, for: .normal)
            }
        }
    }
    
    func changeDate(button: Button) {
        let cellMonth = Calendar.current.component(.month, from: button.date)
        let cellDay = Calendar.current.component(.day, from: button.date)
        let cellYear = Calendar.current.component(.year, from: button.date)
        let components = DateComponents(calendar: Calendar.current, year: cellYear, month: cellMonth, day: cellDay)
        guard let newDate = Calendar.current.date(from: components) else {return}
        selectedDate = newDate
        print(selectedDate)
        if cellMonth != selectedMonth {
            customPicker.selectRow(cellMonth - 1, inComponent: 0, animated: true)
            let startDate = getStartDate(date: newDate)
            setButtons(date: startDate)
            setUpMonthView()
        }
    }
    
    func fetchSymptoms(day: Day, completion:@escaping (Bool) -> Void) {
        var completeCounter = 0
        FlowController.shared.fetchFlowDetails(forDay: day) { (flow) in
            if let flow = flow {
                day.flowDetails = flow
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            } else {
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            }
        }
        SymptomController.shared.fetchSymptoms(forDay: day) { (symptoms) in
            if let symptoms = symptoms {
                day.symptomList = symptoms
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            } else {
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            }
        }
        MoodController.shared.fetchMoods(forDay: day) { (moods) in
            if let moods = moods {
                day.moodList = moods
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            } else {
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            }
        }
        SexController.shared.fetchSexDetails(forDay: day) { (sexDetails) in
            if let sexDetails = sexDetails {
                day.sexDetails = sexDetails
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            } else {
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            }
        }
        CustomEntryController.shared.fetchCustomEntry(forDay: day) { (customEntry) in
            if let customEntry = customEntry {
                day.customEntry = customEntry
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            } else {
                completeCounter += 1
                if completeCounter == 5 {
                    completion(true)
                }
            }
        }
    }
    
    func convertSymptomsToString(day: Day) {
        var symptomArray: [String] = []
        if let flowDetails = day.flowDetails {
            if flowDetails.spotting {
                symptomArray.append("Spotting")
            } else if flowDetails.light {
                symptomArray.append("Light Flow")
            } else if flowDetails.medium {
                symptomArray.append("Medium Flow")
            } else if flowDetails.heavy {
                symptomArray.append("Heavy Flow")
            }
        }
        if let symptoms = day.symptomList {
            if symptoms.acne {
                symptomArray.append("Acne")
            }
            if symptoms.backPain {
                symptomArray.append("Back Pain")
            }
            if symptoms.breastTenderness {
                symptomArray.append("Tender Breasts")
            }
            if symptoms.cramping {
                symptomArray.append("Cramps")
            }
            if symptoms.fatigue {
                symptomArray.append("Fatigue")
            }
            if symptoms.headache {
                symptomArray.append("Headache")
            }
            if symptoms.insomnia {
                symptomArray.append("Insomnia")
            }
            if symptoms.nausea {
                symptomArray.append("Nausea")
            }
        }
        if let mood = day.moodList {
            if mood.happy {
                symptomArray.append("Happy")
            }
            if mood.angry {
                symptomArray.append("Angry")
            }
            if mood.depressed {
                symptomArray.append("Depressed")
            }
            if mood.irritated {
                symptomArray.append("Irritated")
            }
            if mood.moodSwings {
                symptomArray.append("Mood Swings")
            }
            if mood.content {
                symptomArray.append("Content")
            }
            if mood.nervous {
                symptomArray.append("Nervous")
            }
            if mood.sad {
                symptomArray.append("Sad")
            }
            if mood.sensitive {
                symptomArray.append("Sensitive")
            }
        }
        if let sex = day.sexDetails {
            if sex.protected {
                symptomArray.append("Protected Sex")
            } else if sex.unprotected {
                symptomArray.append("Unprotected Sex")
            }
            if sex.masturbation {
                symptomArray.append("Masturbation")
            }
            if sex.sexDrive {
                symptomArray.append("High Sex Drive")
            }
            if sex.lowDrive {
                symptomArray.append("Low Sex Drive")
            }
        }
        if let custom = day.customEntry {
            let text = custom.text
            if text != "" {
                symptomArray.append(text)
            }
        }
        
        self.symptomData = symptomArray
        DispatchQueue.main.async {
            self.symptomCollectionView.reloadData()
        }
    }
    
    func displayPeriod(button: Button, user: User) {
        for cycle in user.cycles {
            let dateInterval = DateInterval(start: cycle.cycleDateStart, end: cycle.periodEndDate)
            if cycle.cycleDateStart == button.date {
                button.button.setBackgroundImage(#imageLiteral(resourceName: "periodStartBackground"), for: .normal)
                break
            } else if cycle.periodEndDate == button.date {
                button.button.setBackgroundImage(#imageLiteral(resourceName: "periodEndBackground"), for: .normal)
                break
            } else if dateInterval.contains(button.date) {
                button.button.setBackgroundImage(#imageLiteral(resourceName: "periodMidBackground"), for: .normal)
                break
            } else {
                button.button.setBackgroundImage(nil, for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSymptomVC" {
            let destination = segue.destination as? AddSymptomsTableViewController
            for button in classArray {
                if button.date == selectedDate {
                    let day = button.day ?? nil
                    destination?.dayObject = day
                    break
                }
            }
            destination?.viewedDate = selectedDate
        }
        if segue.identifier == "toConfirmPopupVC" {
            let destination = segue.destination as? ConfirmNewCyclePopupViewController
            destination?.date = selectedDate
        }
    }
    
}//end of class

extension CalendarTabViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 12
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            let monthData = months[row]
            let month = NSAttributedString(string: monthData, attributes: [NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 21)!])
            return month
        case 1:
            let yearData = String(years[row])
            let year = NSAttributedString(string: yearData, attributes: [NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 21)!])
            return year
        default:
            let empty = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 21)!])
            return empty
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        let indexpath = IndexPath(item: row, section: component)
        //        firstSelectedDay = customPickerData[IndexPath]
        switch component{
        case 0:
            selectedMonth = row + 1
            let dateComponents = DateComponents(calendar: Calendar.current, year: selectedYear, month: selectedMonth, day: 1)
            let date = Calendar.current.date(from: dateComponents)!
            selectedDate = date
            let firstCalendarDate = getStartDate(date: selectedDate)
            setButtons(date: firstCalendarDate)
        case 1:
            let year = years[row]
            selectedYear = year
            let dateComponents = DateComponents(calendar: Calendar.current, year: selectedYear, month: selectedMonth, day: 1)
            let date = Calendar.current.date(from: dateComponents)!
            selectedDate = date
            let firstCalendarDate = getStartDate(date: date)
            setButtons(date: firstCalendarDate)
        default:
            break
        }
    }
}

extension CalendarTabViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symptomData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "symptomCell", for: indexPath) as! SymptomCollectionViewCell
        
        cell.symptomLabel.text = "- \(symptomData[indexPath.row])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2.1
        let height = collectionView.bounds.width/15
        return CGSize(width: width, height: height)
    }
}

