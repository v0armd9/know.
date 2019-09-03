//
//  ShareViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 9/3/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit
import CloudKit

class ShareViewController: UIViewController {

    
    //Outlets
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func shareButtonTapped(_ sender: Any) {
        presentShareController()
    }
    
    //Set Navigation Bar
    func setNavBarView() {
        let label = UILabel()
        label.text = "Sharing"
        label.textColor = #colorLiteral(red: 0.554766655, green: 0.7184440494, blue: 0.8180738091, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont(name: "Nunito-Bold", size: 25)
        navigationItem.titleView = label
    }

    //CloudKit Share Controller View
    func presentShareController() {
        guard let user = UserController.shared.currentUser else { return }
        let userRecord = CKRecord(user: user)
        let sharingController = UICloudSharingController { (controller, preparationHandler) in
            CloudKitController.shared.share(record: userRecord, type: UserConstants.userTypeKey, completion: preparationHandler)
        }
        sharingController.delegate = self
        DispatchQueue.main.async {
            self.present(sharingController, animated: true)
        }
    }
}

extension ShareViewController: UICloudSharingControllerDelegate {
    func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
        print("Uh Oh! The share failed!")
    }
    
    func itemTitle(for csc: UICloudSharingController) -> String? {
        return csc.title
    }
}

//Button indicators of symptoms listed forday or current date indicator
//func buttonTapped(button: UIButton, dayNumber: Int) {
//    if let previousButton = self.selectedButton {
//        //set button back to normal state
//        let buttonTitle = NSAttributedString(string: String(dayNumber), attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#96B6CE")])
//        button.setAttributedTitle(buttonTitle, for: .normal)
//        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: <#T##UIControl.State#>)
//        //Set new button as selected
//        selectedButton = button
//        //set new selected button image/formatting
//        button.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
//    }
//}
