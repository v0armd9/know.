//
//  Day.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Day {
    
    //Class Objects
    var date: Date
    var flowDetails: Flow?
    var symptomList: Symptom?
    var moodList: Mood?
    var sexDetails: Sex?
    var customEntry: CustomEntry?
    var ckRecordID: CKRecord.ID
    weak var user: User?
    
    var userReference: CKRecord.Reference? {
        guard let user = user else { return nil }
        return CKRecord.Reference(recordID: user.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(user: User, date: Date, flowDetails: Flow?, symptomList: Symptom?, moodList: Mood?, sexDetails: Sex?, customEntry: CustomEntry?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.user = user
        self.date = date
        self.flowDetails = flowDetails
        self.symptomList = symptomList
        self.moodList = moodList
        self.sexDetails = sexDetails
        self.customEntry = customEntry
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, user: User) {
        guard let date = record[DayConstants.dateKey] as? Date else { return nil }
        self.init(user: user, date: date, flowDetails: nil, symptomList: nil, moodList: nil, sexDetails: nil, customEntry: nil, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(day: Day) {
        self.init(recordType: DayConstants.dayTypeKey, recordID: day.ckRecordID)
        self.setValue(day.date, forKey: DayConstants.dateKey)
        self.setValue(day.userReference, forKey: DayConstants.userReference)
    }
}

//Conform to Equatable for Deletion
extension Day: Equatable {
    static func ==(lhs: Day, rhs: Day) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct DayConstants {
    static let dayTypeKey = "Day"
    static let dateKey = "date"
    static let userReference = "userReference"
    fileprivate static let flowKey = "flowDetails"
    fileprivate static let symptomKey = "symptomList"
    fileprivate static let moodKey = "moodList"
    fileprivate static let sexKey = "sexDetails"
    fileprivate static let entryKey = "customEntry"
}
