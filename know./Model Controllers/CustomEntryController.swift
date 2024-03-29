//
//  CustomEntryController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/23/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class CustomEntryController {
    
    static let shared = CustomEntryController()
    var customEntries: [CustomEntry] = []
    
    func saveEntry(forDay day: Day, text: String, completion: @escaping(CustomEntry?) -> Void) {
        let entry = CustomEntry(day: day, text: text)
        let record = CKRecord(customEntry: entry)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let entry = CustomEntry(record: record, day: day) else { return }
                print("Custom Entry Saved on CustomEntryController")
                completion(entry)
            }
        }
    }
    
    func fetchCustomEntries(forDay day: Day, completion: @escaping([CustomEntry]?) -> Void) {
        let dayID = day.ckRecordID
        let dayPreicate = NSPredicate(format: "%K == %@", CustomEntryConstants.dayReferenceKey, dayID)
        let entryIDs = day.customEntries.compactMap({$0.ckRecordID})
        let avoidDuplicatePred = NSPredicate(format: "NOT(recordID IN %@)", entryIDs)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dayPreicate, avoidDuplicatePred])
        CloudKitController.shared.fetchRecords(ofType: CustomEntryConstants.customTypeKey, withPredicate: compoundPredicate) { (records) in
            if let records = records {
                var entries: [CustomEntry] = []
                let entry = records.compactMap({CustomEntry(record: $0, day: day)})
                entries.append(contentsOf: entry)
                print("Custom Entries Fetched on CustomEntryController")
                completion(entries)
            }
        }
    }
    
    func update(entry: CustomEntry, text: String, completion: @escaping(Bool) -> Void) {
        entry.text = text
        let record = CKRecord(customEntry: entry)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("Custom Entry Updated on CustomEntryController")
                completion(true)
            } else {
                print("Custom Entry Failed to Update on CustomEntryController")
                completion(false)
            }
        }
    }
    
    func deleteDetails(forEntry entry: CustomEntry, fromDay day: Day, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: entry.ckRecordID) { (success) in
            if success {
                print("Custom Entry Deleted on CustomEntryController")
                completion(true)
            }
        }
    }
}
