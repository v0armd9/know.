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
    var counter = 0
    var selectedButton: UIButton?
    let arrayOfMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var selectedDate: Date? {
        didSet{
            guard let selectedDate = selectedDate else {return}
            let monthNum = Calendar.current.component(.month, from: selectedDate)
            monthLabel.text = arrayOfMonths[monthNum-1]
        }
    }
    
    var dayObject: Day?
    var flow: [Flow] = []
    var symptoms: [Symptom] = []
    var moods: [Mood] = []
    var sex: [Sex] = []
    var custom: [CustomEntry] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDayData()
        addButtons(buttonCount: 18) { (success) in
            if success {
                self.selectedDate = Date()
                self.updateButtonsFuture()
                self.updateButtonsPast()
            }
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
        if segue.identifier == "toSymptomVC" {
            let destination = segue.destination as? AddSymptomsTableViewController
            guard let day = dayObject else { return }
            destination?.day = day
        }
    }
    
    @IBAction func viewSwipedUp(_ sender: UISwipeGestureRecognizer) {
        swipeUp()
    }
    
    @IBAction func viewSwipedDown(_ sender: UISwipeGestureRecognizer) {
        swipeDown()
    }
    
    func fetchDayData() {
        guard let user = UserController.shared.currentUser else { return }
        let date = selectedDate ?? Date()
        DayController.shared.fetchSingleDay(forUser: user, andDate: date) { (day) in
            if let day = day {
                self.dayObject = day
                self.flow = day.flowDetails
                self.symptoms = day.symptomList
                self.moods = day.moodList
                self.sex = day.sexDetails
                self.custom = day.customEntries
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
        print(date)
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
        self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate!)!
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
        self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate!)!
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
        print(self.counter)
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
        print(self.counter)
        UIView.animate(withDuration: 1) {
            self.wheelView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/9) * CGFloat(self.counter))
            for button in self.wheelView.subviews {
                button.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/9) * CGFloat(self.counter))
            }
        }
        reorderSubviewsBackward()
    }
}
