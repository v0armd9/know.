//
//  Sex.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Sex {
    
    //Class Objects
    var protected: Bool
    var unprotected: Bool
    var sexDrive: Bool
    var lowDrive: Bool
    var masturbation: Bool
    var ckRecordID: CKRecord.ID
    weak var day: Day?
    
    var dayReference: CKRecord.Reference? {
        guard let day = day else { return nil }
        return CKRecord.Reference(recordID: day.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(day: Day, protected: Bool = false, unprotected: Bool = false, sexDrive: Bool = false, lowDrive: Bool = false, masturbation: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.day = day
        self.protected = protected
        self.unprotected = unprotected
        self.sexDrive = sexDrive
        self.lowDrive = lowDrive
        self.masturbation = masturbation
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, day: Day) {
        guard let protected = record[SexConstants.protectedKey] as? Bool,
            let unprotected = record[SexConstants.unprotectedKey] as? Bool,
            let sexDrive = record[SexConstants.sexDriveKey] as? Bool,
            let lowDrive = record[SexConstants.lowDriveKey] as? Bool,
            let masturbation = record[SexConstants.masturbationKey] as? Bool
            else { return nil }
        self.init(day: day, protected: protected, unprotected: unprotected, sexDrive: sexDrive, lowDrive: lowDrive, masturbation: masturbation, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(sex: Sex) {
        self.init(recordType: SexConstants.sexTypeKey, recordID: sex.ckRecordID)
        self.setValue(sex.protected, forKey: SexConstants.protectedKey)
        self.setValue(sex.unprotected, forKey: SexConstants.unprotectedKey)
        self.setValue(sex.sexDrive, forKey: SexConstants.sexDriveKey)
        self.setValue(sex.lowDrive, forKey: SexConstants.lowDriveKey)
        self.setValue(sex.masturbation, forKey: SexConstants.masturbationKey)
        self.setValue(sex.dayReference, forKey: SexConstants.dayReferenceKey)
    }
}

//Conform to Equatable for Deletion
extension Sex: Equatable {
    static func ==(lhs: Sex, rhs: Sex) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct SexConstants {
    static let sexTypeKey = "Sex"
    static let dayReferenceKey = "day"
    fileprivate static let protectedKey = "protected"
    fileprivate static let unprotectedKey = "unprotected"
    fileprivate static let sexDriveKey = "sexDrive"
    fileprivate static let lowDriveKey = "lowDrive"
    fileprivate static let masturbationKey = "masturbation"
}
