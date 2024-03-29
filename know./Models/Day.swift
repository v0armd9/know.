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
    var flowDetails: [Flow]
    var symptomList: [Symptom]
    var moodList: [Mood]
    var sexDetails: [Sex]
    var customEntries: [CustomEntry]
    var ckRecordID: CKRecord.ID
    weak var user: User?
    
    //Designated Initializer
    init(user: User, date: Date, flowDetails: [Flow] = [], symptomList: [Symptom] = [], moodList: [Mood] = [], sexDetails: [Sex] = [], customEntries: [CustomEntry] = [], ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.date = date
        self.flowDetails = flowDetails
        self.symptomList = symptomList
        self.moodList = moodList
        self.sexDetails = sexDetails
        self.customEntries = customEntries
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, user: User) {
        guard let date = record[DayConstants.dateKey] as? Date
            else { return nil }
        self.init(user: user, date: date, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(day: Day) {
        self.init(recordType: DayConstants.dayTypeKey, recordID: day.ckRecordID)
        self.setValue(day.date, forKey: DayConstants.dateKey)
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
    fileprivate static let dateKey = "date"
    fileprivate static let flowKey = "flowDetails"
    fileprivate static let symptomKey = "symptomList"
    fileprivate static let moodKey = "moodList"
    fileprivate static let sexKey = "sexDetails"
    fileprivate static let entryKey = "customEntries"
}
