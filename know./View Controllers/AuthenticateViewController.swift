//
//  AuthenticateViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/27/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticateViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var continueButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfAuthRequired()
    }
    
    //Helper Function
    func checkIfAuthRequired() {
        if UserController.shared.currentUser?.authEnabled == true {
            print("User Requires Authentication")
            authenticateUser()
        } else {
            print("User Does Not Require Authentication")
            self.performSegue(withIdentifier: "toHomeScreenVC", sender: self)
        }
    }
    
    func authenticateUser() {
        let authContext = LAContext()
        var authError: NSError?
        authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError)
        if authError != nil {
            print("Authentication not available on this device")
            let alertController = UIAlertController (title: "Uh Oh!", message: "Authentication is not supported on this device. Please Disable User Authentication in your settings.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (_) -> Void in
                self.performSegue(withIdentifier: "toHomeScreenVC", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true)
        } else {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock to view App Information") { (success, error) in
                if let error = error {
                    print("Authentication Error")
                    print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                    DispatchQueue.main.async {
                        let alertController = UIAlertController (title: "Uh Oh!", message: "There was an error authenticating your account. Please try again later.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Dismiss", style: .default)
                        alertController.addAction(action)
                        self.present(alertController, animated: true)
                    }
                } else {
                    if success {
                        print("Authentication was successful")
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "toHomeScreenVC", sender: self)
                        }
                    } else {
                        print("Authentication Failed")
                    }
                }
            }
        }
    }
}
