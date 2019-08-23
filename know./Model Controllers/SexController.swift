//
//  SexController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class SexController {
    
    static let shared = SexController()
    var sexDetails: [Sex] = []
    
    func saveSexDetails(forDay day: Day, protected: Bool, sexDrive: Bool, masturbation: Bool, completion: @escaping(Sex?) -> Void) {
        let sex = Sex(day: day, protected: protected, sexDrive: sexDrive, masturbation: masturbation)
        let record = CKRecord(sex: sex)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let sex = Sex(record: record, day: day) else { return }
                print("Sex Saved on SexController")
                completion(sex)
            }
        }
    }
    
    func fetchSexDetails(forDay day: Day, completion: @escaping([Sex]?) -> Void) {
        let dayID = day.ckRecordID
        let dayPreicate = NSPredicate(format: "%K == %@", MoodConstants.dayReferenceKey, dayID)
        let sexIDs = day.sexDetails.compactMap({$0.ckRecordID})
        let avoidDuplicatePred = NSPredicate(format: "NOT(recordID IN %@)", sexIDs)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dayPreicate, avoidDuplicatePred])
        CloudKitController.shared.fetchRecords(ofType: SexConstants.sexTypeKey, withPredicate: compoundPredicate) { (records) in
            if let records = records {
                var sexDetails: [Sex] = []
                let sex = records.compactMap({Sex(record: $0, day: day)})
                sexDetails.append(contentsOf: sex)
                print("SexDetails Fetched on SexController")
                completion(sexDetails)
            }
        }
    }
    
    func update(sexDetails: Sex, withProtected protected: Bool, sexDrive: Bool, masturbation: Bool, completion: @escaping(Bool) -> Void) {
        sexDetails.protected = protected
        sexDetails.sexDrive = sexDrive
        sexDetails.masturbation = masturbation
        let record = CKRecord(sex: sexDetails)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("SexDetails Updated on SexController")
                completion(true)
            } else {
                print("SexDetails Failed to Update on SexController")
                completion(false)
            }
        }
    }
    
    func deleteDetails(forSex sex: Sex, fromDay day: Day, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: sex.ckRecordID) { (success) in
            if success {
                print("SexDetails Deleted on SexController")
                completion(true)
            }
        }
    }
}
