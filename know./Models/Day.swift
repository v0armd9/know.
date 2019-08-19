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
    var flowDetails: Flow?
    var symptomList: [Symptom]?
    var moodList: [Mood]?
    var sexDetails: [Sex]?
    var ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(flowDetails: Flow, symptomList: [Symptom], moodList: [Mood], sexDetails: [Sex], ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.flowDetails = flowDetails
        self.symptomList = symptomList
        self.moodList = moodList
        self.sexDetails = sexDetails
        self.ckRecordID = ckRecordID
    }
}
