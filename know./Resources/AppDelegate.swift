//
//  AppDelegate.swift
//  know.
//
//  Created by Darin Armstrong on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func checkForiCloudUser() {
        let container = CKContainer.default()
        container.accountStatus { (status, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            } else {
                switch status {
                //Make sure user is signed into iCloud
                case .available :
                    print("User was found, account status is 'Available'")
                    self.checkForExistingUserData()
                case .restricted :
                    print("User was found, account status is 'Restricted'")
                case .noAccount :
                    print("No Account Found")
                case .couldNotDetermine :
                    print("Account could not be determined")
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    func transitionToAuthVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "homeNavigationController") as! UINavigationController
        self.window?.rootViewController = view
        self.window?.makeKeyAndVisible()
    }
    
    func transitionToOnboardingVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateInitialViewController() as! UINavigationController
        self.window?.rootViewController = view
        self.window?.makeKeyAndVisible()
    }
    
    func checkForExistingUserData() {
        UserController.shared.fetchUser { (success) in
            DispatchQueue.main.async {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                if success {
                    self.transitionToAuthVC()
                } else {
                    self.transitionToOnboardingVC()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        let acceptShareOperation = CKAcceptSharesOperation(shareMetadatas: [cloudKitShareMetadata])
        acceptShareOperation.qualityOfService = .userInteractive
        acceptShareOperation.perShareCompletionBlock = { metadata, share, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                return
            }
            print("Share was accepted")
        }
        acceptShareOperation.acceptSharesCompletionBlock = { error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                return
            }
            CloudKitController.shared.fetchShare(metadata: cloudKitShareMetadata, completion: { (records) in
                if (records != nil) {
                    switch cloudKitShareMetadata.rootRecord?.recordType {
                    case UserConstants.userTypeKey :
                        if let records = records {
                            let users = records.compactMap({User(record: $0)})
                            UserController.shared.viewedUsers = users
                        }
                    default:
                        break
                    }
                }
            })
        }
        CKContainer(identifier: cloudKitShareMetadata.containerIdentifier).add(acceptShareOperation)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkForiCloudUser()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

