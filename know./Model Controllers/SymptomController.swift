//
//  SymptomController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class SymptomController {
    
    static let shared = SymptomController()
    var symptoms: [Symptom] = []
    
    func saveSymptoms(forDay day: Day, headache: Bool, cramping: Bool, backPain: Bool, breastTenderness: Bool, nausea: Bool, fatigue: Bool, insomnia: Bool, acne: Bool, completion: @escaping(Bool) -> Void) {
        let symptom = Symptom(day: day, headache: headache, cramping: cramping, backPain: backPain, breastTenderness: breastTenderness, nausea: nausea, fatigue: fatigue, insomnia: insomnia, acne: acne)
        let record = CKRecord(symptom: symptom)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let symptom = Symptom(record: record, day: day) else { return }
                self.symptoms.append(symptom)
                print("Symptom Saved on SymptomController")
                completion(true)
            }
        }
    }
    
    func fetchSymptoms(forDay day: Day, completion: @escaping(Symptom?) -> Void) {
        let dayID = day.ckRecordID
        let dayPreicate = NSPredicate(format: "%K == %@", SymptomConstants.dayReferenceKey, dayID)
        guard let symptomID = day.symptomList?.ckRecordID else { return }
        let avoidDuplicatePred = NSPredicate(format: "NOT(recordID IN %@)", symptomID)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dayPreicate, avoidDuplicatePred])
        CloudKitController.shared.fetchRecords(ofType: SymptomConstants.symptomTypeKey, withPredicate: compoundPredicate) { (records) in
            if let records = records {
                var symptoms: [Symptom] = []
                let symptom = records.compactMap({Symptom(record: $0, day: day)})
                symptoms.append(contentsOf: symptom)
                print("Symptoms Fetched on SymptomController")
                completion(symptoms.first)
            }
        }
    }
    
    func update(symptom: Symptom, withHeadache headache: Bool, cramping: Bool, backPain: Bool, breastTenderness: Bool, nausea: Bool, fatigue: Bool, insomnia: Bool, acne: Bool, completion: @escaping(Bool) -> Void) {
        symptom.headache = headache
        symptom.cramping = cramping
        symptom.backPain = backPain
        symptom.breastTenderness = breastTenderness
        symptom.nausea = nausea
        symptom.fatigue = fatigue
        symptom.insomnia = insomnia
        symptom.acne = acne
        let record = CKRecord(symptom: symptom)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("Symptom Updated on SymptomController")
                completion(true)
            } else {
                print("Symptom Failed to Update on SymptomController")
                completion(false)
            }
        }
    }
    
    func deleteDetails(forSymptom symptom: Symptom, fromDay day: Day, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: symptom.ckRecordID) { (success) in
            if success {
                print("Symptom Details Deleted on SymptomController")
                completion(true)
            }
        }
    }
}
