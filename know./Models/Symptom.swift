//
//  Symptom.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Symptom {
    
    //Class Objects
    var headache: Bool
    var cramping: Bool
    var backPain: Bool
    var breastTenderness: Bool
    var nausea: Bool
    var fatigue: Bool
    var insomnia: Bool
    var acne: Bool
    var ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(headache: Bool = false, cramping: Bool = false, backPain: Bool = false, breastTenderness: Bool = false, nausea: Bool = false, fatigue: Bool = false, insomnia: Bool = false, acne: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.headache = headache
        self.cramping = cramping
        self.backPain = backPain
        self.breastTenderness = breastTenderness
        self.nausea = nausea
        self.fatigue = fatigue
        self.insomnia = insomnia
        self.acne = acne
        self.ckRecordID = ckRecordID
    }
}
