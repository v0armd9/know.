//
//  CustomEntry.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/23/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class CustomEntry {
    
    //Class Objects
    var text: String
    var ckRecordID: CKRecord.ID
    weak var day: Day?
    
    var dayReference: CKRecord.Reference? {
        guard let day = day else { return nil }
        return CKRecord.Reference(recordID: day.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(day: Day, text: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, day: Day) {
        guard let text = record[CustomEntryConstants.textKey] as? String
            else { return nil }
        self.init(day: day, text: text, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(customEntry: CustomEntry) {
        self.init(recordType: CustomEntryConstants.customTypeKey, recordID: customEntry.ckRecordID)
        self.setValue(customEntry.text, forKey: CustomEntryConstants.textKey)
        self.setValue(customEntry.dayReference, forKey: CustomEntryConstants.dayReferenceKey)
    }
}

//Conform to Equatable for Deletion
extension CustomEntry: Equatable {
    static func ==(lhs: CustomEntry, rhs: CustomEntry) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct CustomEntryConstants {
    static let customTypeKey = "CustomEntry"
    static let dayReferenceKey = "day"
    fileprivate static let textKey = "text"
}
