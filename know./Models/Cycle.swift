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
    var cycleDateInterval: DateInterval
    var periodDateInterval: DateInterval
    var recordID: CKRecord.ID
    weak var user: User?
    
    var userReference: CKRecord.Reference? {
        guard let user = user else {return nil}
        return CKRecord.Reference(recordID: user.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(cycleDateInterval: DateInterval, periodDateInterval: DateInterval, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), user: User?) {
        self.user = user
        self.cycleDateInterval = cycleDateInterval
        self.periodDateInterval = periodDateInterval
        self.recordID = recordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, user: User?) {
        guard let cycleDateInterval = record[CycleConstants.cycleDateInterval] as? DateInterval,
        let periodDateInterval = record[CycleConstants.periodDateInterval] as? DateInterval
            else {return nil}
        self.init(cycleDateInterval: cycleDateInterval, periodDateInterval: periodDateInterval, user: user)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(cycle: Cycle) {
        self.init(recordType: CycleConstants.recordType, recordID: cycle.recordID)
        self.setValue(cycle.userReference, forKey: CycleConstants.userReferenceKey)
        self.setValue(cycle.cycleDateInterval, forKey: CycleConstants.cycleDateInterval)
        self.setValue(cycle.periodDateInterval, forKey: CycleConstants.periodDateInterval)
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
    fileprivate static let cycleDateInterval = "CycleDateInterval"
    fileprivate static let periodDateInterval = "PeriodDateInterval"
}
