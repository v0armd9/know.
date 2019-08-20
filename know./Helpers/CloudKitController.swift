//
//  CloudKitController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    
    //Singleton
    static let shared = CloudKitController()
    
    //Database & Zone
    let privateDB = CKContainer.default().privateCloudDatabase
    let sharedDB = CKContainer.default().sharedCloudDatabase
    var knowZone: CKRecordZone?
    
    //Save a Record
    func save(record: CKRecord, completion: @escaping (CKRecord?) -> Void) {
        privateDB.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
            }
            print("Saved Record to CloudKit")
            completion(record)
        }
    }
    
    //Retrieve Records
    func fetchRecords(ofType type: String, withPredicate predicate: NSPredicate, completion: @escaping ([CKRecord]?) -> Void) {
        let query = CKQuery(recordType: type, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let records = records
                else { completion(nil); return }
            print("Fetched Records from CloudKit")
            completion(records)
        }
    }
    
    //Update a record
    func update(record: CKRecord, completion: @escaping (Bool) -> Void ) {
        //Declare operation & set/override attributes (required to change a record)
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
       privateDB.add(operation)
    }
    
    //Delete Record
    func delete(recordID: CKRecord.ID, completion: @escaping (Bool) -> Void) {
        privateDB.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            completion(true)
        }
    }
}
