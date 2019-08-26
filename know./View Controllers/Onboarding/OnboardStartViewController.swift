
//
//  OnboardStartViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class OnboardStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CloudKitController.shared.iCloudUserIDAsync { (recordID, error) in
            if let error = error {
                DispatchQueue.main.async {
                    let alertController = UIAlertController (title: "Uh Oh!", message: "No iCloud Account Found! Please go to Settings and log in to your account.\n\n After logging in, please close the App before running again.", preferredStyle: .alert)
                    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: "App-Prefs:root=GENERAL") else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)")
                            })
                        }
                    }
                    alertController.addAction(settingsAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                print("No iCloud user data found, redirect to settings page (\(error.localizedDescription))")
            }
            if (recordID != nil) {
                print("User is signed into iCloud")
            }
        }
    }
}
