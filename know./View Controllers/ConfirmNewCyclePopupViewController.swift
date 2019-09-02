//
//  ConfirmNewCyclePopupViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/30/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class ConfirmNewCyclePopupViewController: UIViewController {

    //Properties
    var date: Date?
    var confirmed: Bool = false
    var futureDateSelected = false
    
    //Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDate()
        setView()
    }

    //Helper func for view
    func setView() {
        guard let date = date else { return }
        let formattedDate = date.prettyDateString()
        dateLabel.text = formattedDate
        popupView.layer.cornerRadius = 25
    }
    
    func checkDate() {
        guard let date = date else { return }
        if date > Date() {
            futureDateSelected = true
            acceptButton.isHidden = true
            textLabel.text = "Can't select a future date as period start date."
        }
    }
    
    //Actions
    @IBAction func dismissButtonCycle(_ sender: Any) {
        confirmed = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        confirmed = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        confirmed = true
        performSegue(withIdentifier: "unwindToHomeView", sender: self)
    }
}
