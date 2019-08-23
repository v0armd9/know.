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
    var days: [Day]
    var name: String?
    var age: Int?
    var birthdate: Date?
    var height: Int?
    var weight: Int?
    var cycleLength: Int?
    var periodLength: Int?
    var pms: Bool?
    var pmsDuration: Int?
    var lastPeriod: Date?
    var ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(days: [Day] = [], name: String?, age: Int?, birthdate: Date?, height: Int?, weight: Int?, cycleLength: Int?, periodLength: Int?, pms: Bool?, pmsDuration: Int?, lastPeriod: Date?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.days = days
        self.name = name
        self.age = age
        self.birthdate = birthdate
        self.height = height
        self.weight = weight
        self.cycleLength = cycleLength
        self.periodLength = periodLength
        self.pms = pms
        self.pmsDuration = pmsDuration
        self.lastPeriod = lastPeriod
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord) {
        guard let name = record[UserConstants.nameKey] as? String,
            let age = record[UserConstants.ageKey] as? Int,
            let birthdate = record[UserConstants.birthdateKey] as? Date,
            let height = record[UserConstants.heightKey] as? Int,
            let weight = record[UserConstants.weightKey] as? Int,
            let cycleLength = record[UserConstants.cycleKey] as? Int,
            let periodLength = record[UserConstants.periodKey] as? Int,
            let pms = record[UserConstants.pmsKey] as? Bool,
            let pmsDuration = record[UserConstants.pmsDurationKey] as? Int,
            let lastPeriod = record[UserConstants.lastPeriodKey] as? Date
            else { return nil }
        self.init(name: name, age: age, birthdate: birthdate, height: height, weight: weight, cycleLength: cycleLength, periodLength: periodLength, pms: pms, pmsDuration: pmsDuration, lastPeriod: lastPeriod, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: UserConstants.userTypeKey, recordID: user.ckRecordID)
        self.setValue(user.name, forKey: UserConstants.nameKey)
        self.setValue(user.age, forKey: UserConstants.ageKey)
        self.setValue(user.birthdate, forKey: UserConstants.birthdateKey)
        self.setValue(user.height, forKey: UserConstants.heightKey)
        self.setValue(user.weight, forKey: UserConstants.weightKey)
        self.setValue(user.cycleLength, forKey: UserConstants.cycleKey)
        self.setValue(user.periodLength, forKey: UserConstants.periodKey)
        self.setValue(user.pms, forKey: UserConstants.pmsKey)
        self.setValue(user.pmsDuration, forKey: UserConstants.pmsDurationKey)
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
    fileprivate static let birthdateKey = "birthdate"
    fileprivate static let heightKey = "height"
    fileprivate static let weightKey = "weight"
    fileprivate static let cycleKey = "cycleLength"
    fileprivate static let periodKey = "periodLength"
    fileprivate static let pmsKey = "pms"
    fileprivate static let pmsDurationKey = "pmsDuration"
    fileprivate static let lastPeriodKey = "lastPeriod"
}
