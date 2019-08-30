//
//  Cycle.swift
//  know.
//
//  Created by Darin Armstrong on 8/29/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Cycle {
    
    //Class Properties
    var cycleDateStart: Date
    var periodEndDate: Date
    var cycleEndDate: Date
    var recordID: CKRecord.ID
    weak var user: User?
    
    var userReference: CKRecord.Reference? {
        guard let user = user else {return nil}
        return CKRecord.Reference(recordID: user.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(cycleDateStart: Date, periodEndDate: Date, cycleEndDate: Date, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), user: User?) {
        self.user = user
        self.cycleDateStart = cycleDateStart
        self.periodEndDate = periodEndDate
        self.cycleEndDate = cycleEndDate
        self.recordID = recordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, user: User?) {
        guard let cycleDateStart = record[CycleConstants.cycleDateStart] as? Date,
        let periodEndDate = record[CycleConstants.periodEndDate] as? Date,
            let cycleEndDate = record[CycleConstants.cycleEndDate] as? Date
            else {return nil}
        self.init(cycleDateStart: cycleDateStart, periodEndDate: periodEndDate, cycleEndDate: cycleEndDate, recordID: record.recordID, user: user)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(cycle: Cycle) {
        self.init(recordType: CycleConstants.recordType, recordID: cycle.recordID)
        self.setValue(cycle.userReference, forKey: CycleConstants.userReferenceKey)
        self.setValue(cycle.cycleDateStart, forKey: CycleConstants.cycleDateStart)
        self.setValue(cycle.periodEndDate, forKey: CycleConstants.periodEndDate)
        self.setValue(cycle.cycleEndDate, forKey: CycleConstants.cycleEndDate)
    }
}

//Conform to Equatable
extension Cycle: Equatable {
    static func == (lhs: Cycle, rhs: Cycle) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

//Magic String Constants
struct CycleConstants {
    static let recordType = "Cycle"
    static let userReferenceKey = "UserReference"
    fileprivate static let cycleDateStart = "CycleDateStart"
    fileprivate static let periodEndDate = "PeriodEndDate"
    fileprivate static let cycleEndDate = "CycleEndDate"
}
