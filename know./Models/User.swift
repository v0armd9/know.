//
//  User.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    //Class Objects
    var name: String
    var age: Int
    var height: Int
    var weight: Int
    var cycleLength: Int
    var periodLength: Int
    var pms: Bool
    var lastPeriod: Date
    var ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(name: String, age: Int, height: Int, weight: Int, cycleLength: Int, periodLength: Int, pms: Bool, lastPeriod: Date, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.cycleLength = cycleLength
        self.periodLength = periodLength
        self.pms = pms
        self.lastPeriod = lastPeriod
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord) {
        guard let name = record[UserConstants.nameKey] as? String,
            let age = record[UserConstants.ageKey] as? Int,
        let height = record[UserConstants.heightKey] as? Int,
        let weight = record[UserConstants.weightKey] as? Int,
        let cycleLength = record[UserConstants.cycleKey] as? Int,
        let periodLength = record[UserConstants.periodKey] as? Int,
        let pms = record[UserConstants.pmsKey] as? Bool,
        let lastPeriod = record[UserConstants.lastPeriodKey] as? Date
            else { return nil }
        self.init(name: name, age: age, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, lastPeriod: lastPeriod, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: UserConstants.userTypeKey, recordID: user.ckRecordID)
        self.setValue(user.name, forKey: UserConstants.nameKey)
        self.setValue(user.age, forKey: UserConstants.ageKey)
        self.setValue(user.height, forKey: UserConstants.heightKey)
        self.setValue(user.weight, forKey: UserConstants.weightKey)
        self.setValue(user.cycleLength, forKey: UserConstants.cycleKey)
        self.setValue(user.periodLength, forKey: UserConstants.periodKey)
        self.setValue(user.pms, forKey: UserConstants.pmsKey)
        self.setValue(user.lastPeriod, forKey: UserConstants.lastPeriodKey)
    }
}

//Conform to Equatable for Deletion
extension User: Equatable {
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct UserConstants {
    static let userTypeKey = "User"
    fileprivate static let nameKey = "name"
    fileprivate static let ageKey = "age"
    fileprivate static let heightKey = "height"
    fileprivate static let weightKey = "weight"
    fileprivate static let cycleKey = "cycleLength"
    fileprivate static let periodKey = "periodLength"
    fileprivate static let pmsKey = "pms"
    fileprivate static let lastPeriodKey = "lastPeriod"
}
