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
        authenticateUser()
    }
    
    //Helper Function
    func authenticateUser() {
        let authContext = LAContext()
        var authError: NSError?
        authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError)
        if authError != nil {
            print("Authentication not available on this device")
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
