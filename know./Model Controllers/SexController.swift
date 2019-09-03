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
    var sexDetails: Sex?
    
    func saveSexDetails(forDay day: Day, protected: Bool, unprotected: Bool, sexDrive: Bool, lowDrive: Bool, masturbation: Bool, completion: @escaping(Bool) -> Void) {
        let sex = Sex(day: day, protected: protected, unprotected: unprotected, sexDrive: sexDrive, lowDrive: lowDrive, masturbation: masturbation)
        let record = CKRecord(sex: sex)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let sex = Sex(record: record, day: day) else { return }
                self.sexDetails = sex
                print("Sex Saved")
                completion(true)
            }
        }
    }
    
    func fetchSexDetails(forDay day: Day, completion: @escaping(Sex?) -> Void) {
        let dayID = day.ckRecordID
        let dayPreicate = NSPredicate(format: "%K == %@", SexConstants.dayReferenceKey, dayID)
        CloudKitController.shared.fetchRecords(ofType: SexConstants.sexTypeKey, withPredicate: dayPreicate) { (records) in
            if let records = records {
                var sexDetails: [Sex] = []
                let sex = records.compactMap({Sex(record: $0, day: day)})
                sexDetails.append(contentsOf: sex)
                self.sexDetails = sexDetails.first
                print("SexDetails Fetched")
                completion(sexDetails.first)
            }
        }
    }
    
    func update(sexDetails: Sex, withProtected protected: Bool, unprotected: Bool, sexDrive: Bool, lowDrive: Bool, masturbation: Bool, completion: @escaping(Bool) -> Void) {
        sexDetails.protected = protected
        sexDetails.unprotected = unprotected
        sexDetails.sexDrive = sexDrive
        sexDetails.lowDrive = lowDrive
        sexDetails.masturbation = masturbation
        let record = CKRecord(sex: sexDetails)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("SexDetails Updated")
                self.sexDetails = sexDetails
                completion(true)
            } else {
                print("SexDetails Failed to Update")
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
