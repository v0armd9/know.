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
    
    init() {
        fetchZone(withName: "ShareCycle") { (success) in
            if success {
                print("Record Zone Found")
            } else {
                self.createRecordZone(zoneName: "ShareCycle", completion: { (success) in
                    if success {
                        print("Successfully Created Record Zone")
                    } else {
                        print("Failed to Create Record Zone")
                    }
                })
            }
        }
    }
    
    //Save a Record
    func save(record: CKRecord, completion: @escaping (CKRecord?) -> Void) {
        privateDB.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
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
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
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
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
            print("Updated Record in CloudKit")
        }
       privateDB.add(operation)
    }
    
    //Delete Record
    func delete(recordID: CKRecord.ID, completion: @escaping (Bool) -> Void) {
        privateDB.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(false)
            }
            completion(true)
            print("Deleted Record from CloudKit")
        }
    }
    
    //Create a new CKRecordZone for sharing
    func createRecordZone(zoneName: String, completion: @escaping (Bool) -> Void) {
        let zone = CKRecordZone(zoneID: CKRecordZone.ID(zoneName: zoneName))
        let operation = CKModifyRecordZonesOperation(recordZonesToSave: [zone], recordZoneIDsToDelete: nil)
        operation.modifyRecordZonesCompletionBlock = { savedZone, _, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
        }
            if savedZone != nil, zone == savedZone?.first {
                self.knowZone = savedZone?.first
                completion(true)
            }
        }
        privateDB.add(operation)
    }
    
    //Retrieve Zone if it exists
    func fetchZone(withName name: String, completion: @escaping (Bool) -> Void) {
        privateDB.fetch(withRecordZoneID: CKRecordZone.ID(zoneName: name)) { (foundZone, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            if let foundZone = foundZone {
                self.knowZone = foundZone
                completion(true)
            }
        }
    }
    
    //Create a Share
    public func share(record: CKRecord, type: String, completion: @escaping (CKShare?, CKContainer?, Error?) -> Void) {
        let shareRecordID = CKRecord.ID(recordName: record.recordID.recordName, zoneID: knowZone!.zoneID)
        let recordToShare = CKRecord(recordType: type, recordID: shareRecordID)
        let share = CKShare(rootRecord: recordToShare)
        share[CKShare.SystemFieldKey.title] = "\(record.recordID)" as CKRecordValue?
        share[CKShare.SystemFieldKey.shareType] = "com.DMA.know-" as CKRecordValue?
        let operation = CKModifyRecordsOperation(recordsToSave: [share, recordToShare], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInitiated
        operation.perRecordCompletionBlock = { record, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                print("Failed Per Record Completion")
                completion(nil, nil, error)
            }
        }
        operation.modifyRecordsCompletionBlock = { (_, _, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                print("Failed Modify Completion")
                completion(nil, nil, error)
            } else {
                completion(share, CKContainer.default(), nil)
            }
        }
        privateDB.add(operation)
    }
    
    //Fetch a Share
    public func fetchShare(metadata: CKShare.Metadata, completion: @escaping ([CKRecord]?) -> Void) {
        let operation = CKFetchRecordsOperation(recordIDs: [metadata.rootRecordID])
        operation.perRecordCompletionBlock = { record, _, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return
            }
        }
        operation.fetchRecordsCompletionBlock = { recordDictionary, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return
            }
            if let records = recordDictionary {
                let ckRecords = records.compactMap {$0.value}
                completion(ckRecords)
            }
        }
    }
    
    func iCloudUserIDAsync(complete: @escaping (CKRecord.ID?, NSError?) -> ()) {
        let container = CKContainer.default()
        container.fetchUserRecordID() {
            recordID, error in
            if error != nil {
                print(error!.localizedDescription)
                complete(nil, error as NSError?)
            } else {
                print("fetched ID \(String(describing: recordID?.recordName))")
                complete(recordID, nil)
            }
        }
    }
}

