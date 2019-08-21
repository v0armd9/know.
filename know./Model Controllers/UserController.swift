//
//  UserController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static let shared = UserController()
    
    var currentUser: User?
    
    func saveUser(withName name: String, age: Int, height: Int, weight: Int, cycleLength: Int, periodLength: Int, pms: Bool, lastPeriod: Date, completion: @escaping(Bool) -> Void) {
        let user = User(name: name, age: age, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, lastPeriod: lastPeriod)
        let record = CKRecord(user: user)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let user = User(record: record) else { completion(false); return }
                self.currentUser = user
                print("User Saved on UserController")
                completion(true)
            }
        }
    }
    
    func fetchUser(completion: @escaping(Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        CloudKitController.shared.fetchRecords(ofType: UserConstants.userTypeKey, withPredicate: predicate) { (records) in
            if let records = records {
                guard let userRecord = records.first else { completion(false); return }
                let user = User(record: userRecord)
                self.currentUser = user
                print("User Fetched on UserController")
                completion(true)
            }
        }
    }
    
    func update(user: User, withName name: String, age: Int, height: Int, weight: Int, cycleLength: Int, periodLength: Int, pms: Bool, lastPeriod: Date, completion: @escaping(Bool) -> Void) {
        user.name = name
        user.age = age
        user.height = height
        user.weight = weight
        user.cycleLength = cycleLength
        user.periodLength = periodLength
        user.pms = pms
        user.lastPeriod = lastPeriod
        let record = CKRecord(user: user)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("User Updated on UserController")
                completion(true)
            } else {
                print("User Failed to Update on UserController")
                completion(false)
            }
        }
    }
}
