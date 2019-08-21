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
    weak var day: Day?

    var dayReference: CKRecord.Reference? {
        guard let day = day else { return nil }
        return CKRecord.Reference(recordID: day.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(day: Day, headache: Bool = false, cramping: Bool = false, backPain: Bool = false, breastTenderness: Bool = false, nausea: Bool = false, fatigue: Bool = false, insomnia: Bool = false, acne: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
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
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, day: Day) {
        guard let headache = record[SymptomConstants.headacheKey] as? Bool,
            let cramping = record[SymptomConstants.crampingKey] as? Bool,
        let backPain = record[SymptomConstants.backPainKey] as? Bool,
        let breastTenderness = record[SymptomConstants.breastTendernessKey] as? Bool,
        let nausea = record[SymptomConstants.nauseaKey] as? Bool,
        let fatigue = record[SymptomConstants.fatigueKey] as? Bool,
        let insomnia = record[SymptomConstants.insomniaKey] as? Bool,
        let acne = record[SymptomConstants.acneKey] as? Bool
            else { return nil }
        self.init(day: day, headache: headache, cramping: cramping, backPain: backPain, breastTenderness: breastTenderness, nausea: nausea, fatigue: fatigue, insomnia: insomnia, acne: acne, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(symptom: Symptom) {
        self.init(recordType: SymptomConstants.symptomTypeKey, recordID: symptom.ckRecordID)
        self.setValue(symptom.headache, forKey: SymptomConstants.headacheKey)
        self.setValue(symptom.cramping, forKey: SymptomConstants.crampingKey)
        self.setValue(symptom.backPain, forKey: SymptomConstants.backPainKey)
        self.setValue(symptom.breastTenderness, forKey: SymptomConstants.breastTendernessKey)
        self.setValue(symptom.nausea, forKey: SymptomConstants.nauseaKey)
        self.setValue(symptom.fatigue, forKey: SymptomConstants.fatigueKey)
        self.setValue(symptom.insomnia, forKey: SymptomConstants.insomniaKey)
        self.setValue(symptom.acne, forKey: SymptomConstants.acneKey)
        self.setValue(symptom.dayReference, forKey: SymptomConstants.dayReferenceKey)
    }
}

//Conform to Equatable for Deletion
extension Symptom: Equatable {
    static func ==(lhs: Symptom, rhs: Symptom) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct SymptomConstants {
    static let symptomTypeKey = "Symptom"
    static let dayReferenceKey = "dayReference"
    fileprivate static let headacheKey = "headache"
    fileprivate static let crampingKey = "cramping"
    fileprivate static let backPainKey = "backPain"
    fileprivate static let breastTendernessKey = "breastTenderness"
    fileprivate static let nauseaKey = "nausea"
    fileprivate static let fatigueKey = "fatigue"
    fileprivate static let insomniaKey = "insomnia"
    fileprivate static let acneKey = "acne"
}
