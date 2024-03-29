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
    
    var years: [Int] = []
    
    var selectedMonth: Int?
    var selectedYear: Int?
    
    var selectedDate: Date = Date()
    
    
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
    
    override func viewDidLoad() {
        for number in 2014...2200 {
            years.append(number)
        }
        super.viewDidLoad()
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
        customPicker.delegate = self
        customPicker.dataSource = self
        let currentMonth = Calendar.current.component(.month, from: selectedDate)
        let currentYear = Calendar.current.component(.year, from: selectedDate)
        customPicker.selectRow(currentMonth - 1, inComponent: 0, animated: false)
        customPicker.selectRow(currentYear - 2014, inComponent: 1, animated: false)
        customPicker.reloadAllComponents()
    }
    
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        let button = classArray[0]
        changeDate(button: button)
    }
    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        let button = classArray[1]
        changeDate(button: button)
    }
    
    @IBAction func buttonThreeTapped(_ sender: UIButton) {
        let button = classArray[2]
        changeDate(button: button)
    }
    
    @IBAction func buttonFourTapped(_ sender: UIButton) {
        let button = classArray[3]
        changeDate(button: button)
    }
    
    @IBAction func buttonFiveTapped(_ sender: UIButton) {
        let button = classArray[4]
        changeDate(button: button)
    }
    
    @IBAction func buttonSixTapped(_ sender: Any) {
        let button = classArray[5]
        changeDate(button: button)
    }
    
    @IBAction func buttonSevenTapped(_ sender: UIButton) {
        let button = classArray[6]
        changeDate(button: button)
    }
    
    @IBAction func buttonEightTapped(_ sender: UIButton) {
        let button = classArray[7]
        changeDate(button: button)
    }
    
    @IBAction func buttonNineTapped(_ sender: UIButton) {
        let button = classArray[8]
        changeDate(button: button)
    }
    
    @IBAction func buttonTenTapped(_ sender: UIButton) {
        let button = classArray[9]
        changeDate(button: button)
    }
    
    @IBAction func buttonElevenTapped(_ sender: UIButton) {
        let button = classArray[10]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwelveTapped(_ sender: UIButton) {
        let button = classArray[11]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirteenTapped(_ sender: UIButton) {
        let button = classArray[12]
        changeDate(button: button)
    }
    
    @IBAction func buttonFourteenTapped(_ sender: UIButton) {
        let button = classArray[13]
        changeDate(button: button)
    }
    
    @IBAction func buttonFifteenTapped(_ sender: UIButton) {
        let button = classArray[14]
        changeDate(button: button)
    }
    
    @IBAction func buttonSixteenTapped(_ sender: UIButton) {
        let button = classArray[15]
        changeDate(button: button)
    }
    
    @IBAction func buttonSeventeenTapped(_ sender: UIButton) {
        let button = classArray[16]
        changeDate(button: button)
    }
    
    @IBAction func buttonEighteenTapped(_ sender: UIButton) {
        let button = classArray[17]
        changeDate(button: button)
    }
    
    @IBAction func buttonNineteenTapped(_ sender: UIButton) {
        let button = classArray[18]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyTapped(_ sender: UIButton) {
        let button = classArray[19]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyOneTapped(_ sender: UIButton) {
        let button = classArray[20]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyTwoTapped(_ sender: UIButton) {
        let button = classArray[21]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyThreeTapped(_ sender: UIButton) {
        let button = classArray[22]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyFourTapped(_ sender: UIButton) {
        let button = classArray[23]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyFiveTapped(_ sender: UIButton) {
        let button = classArray[24]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentySixTapped(_ sender: UIButton) {
        let button = classArray[25]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentySevenTapped(_ sender: UIButton) {
        let button = classArray[26]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyEightTapped(_ sender: UIButton) {
        let button = classArray[27]
        changeDate(button: button)
    }
    
    @IBAction func buttonTwentyNineTapped(_ sender: UIButton) {
        let button = classArray[28]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyTapped(_ sender: UIButton) {
        let button = classArray[29]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyOneTapped(_ sender: UIButton) {
        let button = classArray[30]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyTwoTapped(_ sender: UIButton) {
        let button = classArray[31]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyThreeTapped(_ sender: UIButton) {
        let button = classArray[32]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyFourTapped(_ sender: UIButton) {
        let button = classArray[33]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyFiveTapped(_ sender: UIButton) {
        let button = classArray[34]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtySixTapped(_ sender: UIButton) {
        let button = classArray[35]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtySevenTapped(_ sender: UIButton) {
        let button = classArray[36]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyEightTapped(_ sender: UIButton) {
        let button = classArray[37]
        changeDate(button: button)
    }
    
    @IBAction func buttonThirtyNineTapped(_ sender: UIButton) {
        let button = classArray[38]
        changeDate(button: button)
    }
    
    @IBAction func buttonFortyTapped(_ sender: UIButton) {
        let button = classArray[39]
        changeDate(button: button)
    }
    
    @IBAction func buttonFortyOneTapped(_ sender: UIButton) {
        let button = classArray[40]
        changeDate(button: button)
    }
    
    @IBAction func buttonFortyTwoTapped(_ sender: UIButton) {
        let button = classArray[41]
        changeDate(button: button)
    }
    
    
    
    class Button {
        let date: Date
        let button: UIButton
        //let nextButton: Button?
        
        init(date: Date, button: UIButton) {
            self.date = date
            self.button = button
            //self.nextButton = nextButton
        }
    }
    
    func getStartDate(date: Date) -> Date {
        var startDate: Date
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let dateComponents = DateComponents(calendar: Calendar.current, year: year, month: month, day: 1)
        let firstOfMonth = Calendar.current.date(from: dateComponents)!
        let weekDay = Calendar.current.component(.weekday, from: firstOfMonth)
        let daysToSubtract = weekDay - 1
        startDate = Calendar.current.date(byAdding: .day, value: -daysToSubtract, to: firstOfMonth)!
        print(startDate)
        return startDate
    }
    
    func setButtons(date: Date) {
        var date = date
        var classButtons: [Button] = []
        for button in buttons {
            classButtons.append(Button(date: date, button: button))
            print(classButtons.count)
            let dayNumber = Calendar.current.dateComponents([Calendar.Component.day], from: date).day!
            button.setTitle(String(dayNumber), for: .normal)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        classArray = classButtons
        setUpMonthView()
    }
    
    func setUpMonthView() {
        let selectedMonth = Calendar.current.component(.month, from: selectedDate)
        for button in classArray {
            let buttonMonth = Calendar.current.component(.month, from: button.date)
            if selectedMonth != buttonMonth {
                button.button.titleLabel?.textColor = .lightGray
            } else {
                button.button.titleLabel?.textColor = UIColor(hexString: "#96B6CE")
            }
            //toDo showCurrentDate
        }
        let lastRowMonth = Calendar.current.component(.month, from: classArray[35].date)
        if lastRowMonth != selectedMonth {
            self.lastRow.isHidden = true
        } else {
            self.lastRow.isHidden = false
        }
    }
    
    func changeDate(button: Button) {
        let cellMonth = Calendar.current.component(.month, from: button.date)
        let cellDay = Calendar.current.component(.day, from: button.date)
        let cellYear = Calendar.current.component(.year, from: button.date)
        if cellMonth != selectedMonth {
            customPicker.selectRow(cellMonth - 1, inComponent: 0, animated: true)
            let components = DateComponents(calendar: Calendar.current, year: cellYear, month: cellMonth, day: cellDay)
            guard let newDate = Calendar.current.date(from: components) else {return}
            selectedDate = newDate
            let startDate = getStartDate(date: newDate)
            setButtons(date: startDate)
            setUpMonthView()
        }
    }
    
    
}

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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return String(years[row])
        default:
            return ""
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
            let firstCalendarDate = getStartDate(date: date)
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
