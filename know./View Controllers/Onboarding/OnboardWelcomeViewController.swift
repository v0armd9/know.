//
//  OnboardWelcomeViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardWelcomeViewController: UIViewController {

    
    
    //Outlets
    @IBOutlet weak var welcomeLabel: CustomLabel!
    @IBOutlet weak var welcomeImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    //Licecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = UserController.shared.currentUser,
        let name = user.name
            else { return }
        welcomeLabel.text = "Nice to meet you \(name)!"
    }
}
