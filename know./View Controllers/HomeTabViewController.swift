//
//  HomeTabViewController.swift
//  know.
//
//  Created by Darin Armstrong on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var trackerLabel: UILabel!
    
    let wheelView = UIView()
    var confirmed: Bool = false
    var counter = 0
    var dayLateCounter = 0
    var selectedButton: UIButton?
    let arrayOfMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var selectedDate: Date? {
        didSet{
            DispatchQueue.main.async {
                guard let selectedDate = self.selectedDate?.formattedDate() else {return}
                let monthNum = Calendar.current.component(.month, from: selectedDate)
                self.monthLabel.text = self.arrayOfMonths[monthNum-1]
                guard let user = UserController.shared.currentUser else {return}
                var dayNumber = 0
                var remainingNumber = 0
                for cycle in user.cycles {
                    let cycleDateInterval = DateInterval(start: cycle.cycleDateStart, end: cycle.cycleEndDate)
                    if cycleDateInterval.contains(selectedDate) {
                        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
                        let dayDurationInterval = DateInterval(start: cycle.cycleDateStart.formattedDate(), end: nextDay.formattedDate())
                        let remainingInterval = DateInterval(start: previousDay, end: cycle.cycleEndDate)
                        
                        dayNumber = Int(dayDurationInterval.duration) / 86400
                        remainingNumber = Int(remainingInterval.duration) / 86400
                        self.dayLabel.text = "Cycle Day \(dayNumber)"
                        
                        self.trackerLabel.text = "\(remainingNumber) days until next cycle start"
                        break
                    }
                }
                guard let lastCycleEnd = user.cycles.last?.cycleEndDate else {return}
                
                if self.selectedDate! > lastCycleEnd {
                    print(self.selectedDate)
                    print(lastCycleEnd)
                    self.dayLateCounter = 0
                    var testDate = lastCycleEnd
                    while testDate < self.selectedDate! {
                        self.dayLateCounter += 1
                        testDate = Calendar.current.date(byAdding: .day, value: 1, to: testDate)!
                    }
                    DispatchQueue.main.async {
                        self.dayLabel.text = "\(self.dayLateCounter) Days Late"
                        self.trackerLabel.text = "Let us Know. when your period starts!"
                    }
                }
            }
            self.fetchDayData()
        }
    }
    
    var dayObject: Day?
    var flow: Flow?
    var symptoms: Symptom?
    var moods: Mood?
    var sex: Sex?
    var customEntry: CustomEntry?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDayData()
        addButtons(buttonCount: 18) { (success) in
            if success {
                self.selectedDate = Date().formattedDate()
                self.updateButtonsFuture()
                self.updateButtonsPast()
            }
            self.fetchAllCyclesForUser()
            self.navigationItem.title = "My Cycle ⏏︎"
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if counter > 0 {
                let newCounter = counter
                for _ in 1...newCounter {
                    swipeUp()
                }
            } else if counter < 0 {
                let newCounter = (counter) * (-1)
                for _ in 1...newCounter {
                    swipeDown()
                }
            } else if counter == 0 {
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedDate = self.selectedDate ?? Date()
        if segue.identifier == "toSymptomVC" {
            let destination = segue.destination as? AddSymptomsTableViewController
            let day = dayObject ?? nil
            destination?.dayObject = day
            destination?.viewedDate = selectedDate
            destination?.fetchedFlow = self.flow
            destination?.fetchedSymptoms = self.symptoms
            destination?.fetchedMood = self.moods
            destination?.fetchedSex = self.sex
            destination?.fetchedCustom = self.customEntry
        }
        if segue.identifier == "toConfirmPopupVC" {
            let destination = segue.destination as? ConfirmNewCyclePopupViewController
            guard let selectedDate = self.selectedDate else { return }
            destination?.date = selectedDate
        }
    }
    
    //Get Data from Popup ViewController for Data Fetch
    @IBAction func unwindFromConfirmPopup(segue:UIStoryboardSegue) {
        let data = segue.source as? ConfirmNewCyclePopupViewController
        let confirmed = data?.confirmed ?? false
        if confirmed == true {
            createNewCycle()
        }
    }
    
    @IBAction func viewSwipedUp(_ sender: UISwipeGestureRecognizer) {
        swipeUp()
    }
    
    @IBAction func viewSwipedDown(_ sender: UISwipeGestureRecognizer) {
        swipeDown()
    }
    
    @IBAction func newStartButton(_ sender: UIButton) {
        
    }
    
    func createNewCycle() {
        guard let user = UserController.shared.currentUser else {return}
        let newEndDate = Calendar.current.date(byAdding: .day, value: -1, to: (selectedDate?.formattedDate())!)
        if let lastCycle = user.cycles.last {
            lastCycle.cycleEndDate = newEndDate!
            CycleController.shared.updateCycle(cycle: lastCycle)
            let durationDateInterval = DateInterval(start: lastCycle.cycleDateStart, end: newEndDate!)
            let average = Int(durationDateInterval.duration)/86400
            user.cycleLength?.append(average)
            let name = user.name ?? nil
            let cycles = user.cycles
            let birthdate = user.birthdate ?? nil
            let age = user.age ?? nil
            let height = user.height ?? nil
            let weight = user.weight ?? nil
            let cycleLength = user.cycleLength ?? nil
            let periodLength = user.periodLength ?? nil
            let pms = user.pms ?? nil
            let pmsDuration = user.pmsDuration ?? nil
            let authEnabled = user.authEnabled ?? nil
            UserController.shared.update(user: user, withName: name, cycles: cycles, birthdate: birthdate, age: age, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, pmsDuration: pmsDuration, lastPeriod: (selectedDate?.formattedDate())!, authEnabled: authEnabled) { (success) in
                if success {
                    print("Successfully updated user!")
                }
            }
            var sum = 0
            for int in user.cycleLength! {
                sum += int
            }
            let averageLength = sum/(user.cycleLength!.count)
            let endDate = Calendar.current.date(byAdding: .day, value: averageLength-1, to: (selectedDate?.formattedDate())!)!
            let periodEndDate = Calendar.current.date(byAdding: .day, value: user.periodLength!-1, to: (selectedDate?.formattedDate())!)!
            CycleController.shared.saveCycle(forUser: user, cycleStart: ((selectedDate?.formattedDate())!), periodEnd: periodEndDate, cycleEnd: endDate) { (cycle) in
                if let cycle = cycle {
                    user.cycles.append(cycle)
                    let selectedDate = self.selectedDate?.formattedDate()
                    print("A new cycle was started!")
                    self.selectedDate = selectedDate
                }
            }
        }
    }
    
    func addButtons(buttonCount: Int, completion: @escaping (Bool) -> Void) {
        let wheelView = self.wheelView
        wheelView.frame = CGRect(x: view.frame.minX - (2*((view.frame.height*0.7)/3)), y: view.frame.minY + (view.frame.height*0.15), width: view.frame.height*0.7, height: view.frame.height*0.7)
        
        wheelView.backgroundColor = .clear
        wheelView.layer.cornerRadius = wheelView.frame.height/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.wheelView.frame.midX, y: self.wheelView.frame.midY), radius: wheelView.frame.height / 2, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.init(hexString: "#96B6CE").cgColor
        shapeLayer.borderWidth = 40
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.insertSublayer(shapeLayer, at: 0)
        
        view.addSubview(wheelView)
        
        let range = 1...buttonCount
        let angle = Double.pi / 9
        for n in range {
            let button = UIButton()
            button.frame.size.height = wheelView.frame.height/10
            button.frame.size.width = wheelView.frame.width/10
            button.layer.cornerRadius = button.frame.width/2
            button.center = wheelView.convert(wheelView.center, from: button)
            let doubleIndex = Double(n)
            let radius = Double(wheelView.frame.width/2)
            let cosine = cos(doubleIndex * angle)
            let sine = sin(doubleIndex * angle)
            button.center.x += (CGFloat(radius * cosine))
            button.center.y += (CGFloat(radius * sine))
            wheelView.addSubview(button)
        }
        completion(true)
    }
    
    func updateButtonsFuture() {
        var date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        for n in 0...9 {
            let dayNumber = Calendar.current.component(.day, from: date)
            print(dayNumber)
            let button = wheelView.subviews[n] as? UIButton
            button?.setTitle(String(dayNumber), for: .normal)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            button?.setBackgroundImage(#imageLiteral(resourceName: "wheelButton"), for: .normal)
            button?.titleLabel?.font = UIFont(name: "Nunito-Regular" , size: 30)
        }
    }
    
    func updateButtonsPast() {
        var date = Date()
        var value = -7
        date = Calendar.current.date(byAdding: .day, value: value, to: date)!
        for n in 10...17 {
            let dayNumber = Calendar.current.component(.day, from: date)
            let button = wheelView.subviews[n] as? UIButton
            button?.setTitle(String(dayNumber), for: .normal)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            button?.setBackgroundImage(#imageLiteral(resourceName: "wheelButton"), for: .normal)
            value += 1
            button?.titleLabel?.font = UIFont(name: "Nunito-Regular" , size: 30)
        }
        let selectedButton = wheelView.subviews[17] as? UIButton
        selectedButton?.setBackgroundImage(#imageLiteral(resourceName: "selectedWheelButton"), for: .normal)
        selectedButton?.layer.shadowColor = UIColor.init(hexString: "#96B6CE").cgColor
        selectedButton?.layer.masksToBounds = false
        selectedButton?.layer.shadowOpacity = 1
        selectedButton?.layer.shadowRadius = 15
        selectedButton?.titleLabel?.font = UIFont(name: "Nunito-ExtraBold" , size: 30)
    }
    
    func reorderSubviewsForward() {
        wheelView.insertSubview(wheelView.subviews[0], at: 17)
        let date = Calendar.current.date(byAdding: .day, value: 9, to: selectedDate!)!
        let dayNumber = Calendar.current.component(.day, from: date)
        let button = wheelView.subviews[7] as? UIButton
        button?.setTitle(String(dayNumber), for: .normal)
        self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: (selectedDate?.formattedDate())!)!
        let newButton = wheelView.subviews[17] as? UIButton
        let oldButton = wheelView.subviews[16] as? UIButton
        newButton?.setBackgroundImage(#imageLiteral(resourceName: "selectedWheelButton"), for: .normal)
        newButton?.layer.shadowColor = UIColor.init(hexString: "#96B6CE").cgColor
        newButton?.layer.masksToBounds = false
        newButton?.layer.shadowOpacity = 1
        newButton?.layer.shadowRadius = 15
        newButton?.titleLabel?.font = UIFont(name: "Nunito-ExtraBold" , size: 30)
        oldButton?.setBackgroundImage(#imageLiteral(resourceName: "wheelButton"), for: .normal)
        oldButton?.layer.shadowColor = UIColor.clear.cgColor
        oldButton?.layer.masksToBounds = false
        oldButton?.layer.shadowOpacity = 0.3
        oldButton?.layer.shadowRadius = 15
        oldButton?.titleLabel?.font = UIFont(name: "Nunito-Regular" , size: 30)
    }
    
    func reorderSubviewsBackward() {
        wheelView.insertSubview(wheelView.subviews[17], at: 0)
        let date = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate!)!
        let dayNumber = Calendar.current.component(.day, from: date)
        let button = wheelView.subviews[11] as? UIButton
        button?.setTitle(String(dayNumber), for: .normal)
        self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: (selectedDate?.formattedDate())!)!
        let newButton = wheelView.subviews[17] as? UIButton
        let oldButton = wheelView.subviews[0] as? UIButton
        newButton?.setBackgroundImage(#imageLiteral(resourceName: "selectedWheelButton"), for: .normal)
        newButton?.layer.shadowColor = UIColor.init(hexString: "#96B6CE").cgColor
        newButton?.layer.masksToBounds = false
        newButton?.layer.shadowOpacity = 1
        newButton?.layer.shadowRadius = 15
        newButton?.titleLabel?.font = UIFont(name: "Nunito-ExtraBold" , size: 30)
        oldButton?.setBackgroundImage(#imageLiteral(resourceName: "wheelButton"), for: .normal)
        oldButton?.layer.shadowColor = UIColor.clear.cgColor
        oldButton?.layer.masksToBounds = false
        oldButton?.layer.shadowOpacity = 0.3
        oldButton?.layer.shadowRadius = 15
        oldButton?.titleLabel?.font = UIFont(name: "Nunito-Regular" , size: 30)
    }
    
    func swipeUp() {
        self.counter -= 1
        UIView.animate(withDuration: 1) {
            self.wheelView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/9) * CGFloat(self.counter))
            
            for button in self.wheelView.subviews {
                button.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/9) * CGFloat(self.counter))
            }
        }
        reorderSubviewsForward()
    }
    
    func swipeDown() {
        self.counter += 1
        UIView.animate(withDuration: 1) {
            self.wheelView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/9) * CGFloat(self.counter))
            for button in self.wheelView.subviews {
                button.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/9) * CGFloat(self.counter))
            }
        }
        reorderSubviewsBackward()
    }
    
    
    
    func fetchAllCyclesForUser() {
        guard let user = UserController.shared.currentUser else {return}
        CycleController.shared.fetchCycles(forUser: user) { (cycles) in
            if var cycles = cycles {
                cycles.sort(by: { $0.cycleDateStart < $1.cycleDateStart })
                user.cycles = cycles
                guard let lastCycleEnd = user.cycles.last?.cycleEndDate else {return}
                
                if self.selectedDate! > lastCycleEnd {
                    self.dayLateCounter = 0
                    var testDate = lastCycleEnd
                    while testDate < self.selectedDate! {
                        self.dayLateCounter += 1
                        testDate = Calendar.current.date(byAdding: .day, value: 1, to: testDate)!
                    }
                    DispatchQueue.main.async {
                        self.dayLabel.text = "\(self.dayLateCounter) Days Late"
                        self.trackerLabel.text = "Let us Know. when your period starts!"
                    }
                }
                let selectedDate = self.selectedDate
                self.selectedDate = selectedDate!
                var dayNumber = 0
                var remainingNumber = 0
                for cycle in user.cycles {
                    let cycleDateInterval = DateInterval(start: cycle.cycleDateStart, end: cycle.cycleEndDate)
                    if cycleDateInterval.contains((self.selectedDate?.formattedDate())!) {
                        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: (self.selectedDate?.formattedDate())!)!
                        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: (self.selectedDate?.formattedDate())!)!
                        let dayDurationInterval = DateInterval(start: cycle.cycleDateStart.formattedDate(), end: nextDay.formattedDate())
                        let remainingInterval = DateInterval(start: previousDay, end: cycle.cycleEndDate)
                        
                        dayNumber = Int(dayDurationInterval.duration) / 86400
                        remainingNumber = Int(remainingInterval.duration) / 86400
                        break
                    }
                }
                DispatchQueue.main.async {
                    self.dayLabel.text = "Cycle Day \(dayNumber)"
                    self.trackerLabel.text = "\(remainingNumber) days until next cycle start"
                }
            }
        }
    }
    
    func fetchDayData() {
        guard let user = UserController.shared.currentUser else { return }
        let date = selectedDate ?? Date()
        DayController.shared.fetchSingleDay(forUser: user, andDate: date.formattedDate()) { (day) in
            if let day = day {
                self.fetchSymptomData(day: day)
                self.dayObject = day
                self.dayObject?.flowDetails = self.flow
                self.dayObject?.symptomList = self.symptoms
                self.dayObject?.moodList = self.moods
                self.dayObject?.sexDetails = self.sex
                self.dayObject?.customEntry = self.customEntry
            }
        }
    }
    
    func fetchSymptomData(day: Day) {
        FlowController.shared.fetchFlowDetails(forDay: day) { (flow) in
            if let flow = flow {
                self.flow = flow
            }
        }
        SymptomController.shared.fetchSymptoms(forDay: day) { (symptom) in
            if let symptom = symptom {
                self.symptoms = symptom
            }
        }
        MoodController.shared.fetchMoods(forDay: day) { (mood) in
            if let mood = mood {
                self.moods = mood
            }
        }
        SexController.shared.fetchSexDetails(forDay: day) { (sex) in
            if let sex = sex {
                self.sex = sex
            }
        }
        CustomEntryController.shared.fetchCustomEntry(forDay: day) { (entry) in
            if let entry = entry {
                self.customEntry = entry
            }
        }
    }
}
