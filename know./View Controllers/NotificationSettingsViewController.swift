//
//  NotificationSettingsViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 9/3/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class NotificationSettingsViewController: UIViewController {

    //Properties
    let user = UserController.shared.currentUser
    let upcomingNotificationEnabled = UserController.shared.currentUser?.upcomingNotificationEnabled
    let lateNotificationEnabled = UserController.shared.currentUser?.lateNotificationEnabled
    
    //Outlets
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var lateLabel: UILabel!
    @IBOutlet weak var upcomingEnableButton: UIButton!
    @IBOutlet weak var upcomingDisableButton: UIButton!
    @IBOutlet weak var lateEnableButton: UIButton!
    @IBOutlet weak var lateDisableButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarView()
        checkUserSettings()
    }
    
    //Set Navigation Bar
    func setNavBarView() {
        let label = UILabel()
        label.text = "Notifications"
        label.textColor = #colorLiteral(red: 0.554766655, green: 0.7184440494, blue: 0.8180738091, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont(name: "Nunito-Bold", size: 25)
        navigationItem.titleView = label
    }

    //Actions
    @IBAction func upcomingEnableBT(_ sender: Any) {
        updateToggledButtons(select: upcomingEnableButton, deselect: upcomingDisableButton)
        NotificationController.shared.scheduleUpcomingPeriodAlert()
    }
    
    @IBAction func upcomingDisableBT(_ sender: Any) {
        updateToggledButtons(select: upcomingDisableButton, deselect: upcomingEnableButton)
        NotificationController.shared.cancelUpcomingPeriodAlert()
    }
    
    @IBAction func lateEnableBT(_ sender: Any) {
        updateToggledButtons(select: lateEnableButton, deselect: lateDisableButton)
        NotificationController.shared.scheduleLatePeriodAlert()
    }
    
    @IBAction func lateDisableBT(_ sender: Any) {
        updateToggledButtons(select: lateDisableButton, deselect: lateEnableButton)
        NotificationController.shared.cancelLatePeriodAlert()
    }
    
    func checkUserSettings() {
        if upcomingNotificationEnabled == true {
            updateToggledButtons(select: upcomingEnableButton, deselect: upcomingDisableButton)
        } else {
            updateToggledButtons(select: upcomingDisableButton, deselect: upcomingEnableButton)
        }
        if lateNotificationEnabled == true {
            updateToggledButtons(select: lateEnableButton, deselect: lateDisableButton)
        } else {
            updateToggledButtons(select: lateDisableButton, deselect: lateEnableButton)
        }
    }
    
    //Button Status
    func updateToggledButtons(select button: UIButton, deselect: UIButton) {
        if button.isSelected == false {
            button.isSelected = true
            deselect.isSelected = false
        }
    }
}
