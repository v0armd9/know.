//
//  Flow.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Flow {
    
    //Class Objects
    var spotting: Bool
    var light: Bool
    var medium: Bool
    var heavy: Bool
    var ckRecordID: CKRecord.ID
    weak var day: Day?
    
    var dayReference: CKRecord.Reference? {
        guard let day = day else { return nil }
        return CKRecord.Reference(recordID: day.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(day: Day, spotting: Bool = false, light: Bool = false, medium: Bool = false, heavy: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.spotting = spotting
        self.light = light
        self.medium = medium
        self.heavy = heavy
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, day: Day) {
        guard let spotting = record[FlowConstants.spottingKey] as? Bool,
        let light = record[FlowConstants.lightKey] as? Bool,
        let medium = record[FlowConstants.mediumKey] as? Bool,
        let heavy = record[FlowConstants.heavyKey] as? Bool
            else { return nil }
        self.init(day: day, spotting: spotting, light: light, medium: medium, heavy: heavy, ckRecordID: record.recordID)
    }

}

//Initialize a record from a class object
extension CKRecord {
    convenience init(flow: Flow) {
        self.init(recordType: FlowConstants.flowTypeKey, recordID: flow.ckRecordID)
        self.setValue(flow.spotting, forKey: FlowConstants.spottingKey)
        self.setValue(flow.light, forKey: FlowConstants.lightKey)
        self.setValue(flow.medium, forKey: FlowConstants.mediumKey)
        self.setValue(flow.heavy, forKey: FlowConstants.heavyKey)
        self.setValue(flow.dayReference, forKey: FlowConstants.dayReferenceKey)
    }
}

//Conform to Equatable for Deletion
extension Flow: Equatable {
    static func ==(lhs: Flow, rhs: Flow) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct FlowConstants {
    static let flowTypeKey = "Flow"
    fileprivate static let spottingKey = "spotting"
    fileprivate static let lightKey = "light"
    fileprivate static let mediumKey = "medium"
    fileprivate static let heavyKey = "heavy"
    fileprivate static let dayReferenceKey = "dayReference"
}
