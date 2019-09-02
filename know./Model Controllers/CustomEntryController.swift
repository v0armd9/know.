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
    var customEntries: CustomEntry?
    
    func saveEntry(forDay day: Day, text: String, completion: @escaping(Bool) -> Void) {
        let entry = CustomEntry(day: day, text: text)
        let record = CKRecord(customEntry: entry)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let entry = CustomEntry(record: record, day: day) else { return }
                self.customEntries = entry
                print("Custom Entry Saved on CustomEntryController")
                completion(true)
            }
        }
    }
    
    func fetchCustomEntry(forDay day: Day, completion: @escaping(CustomEntry?) -> Void) {
        let dayID = day.ckRecordID
        let dayPreicate = NSPredicate(format: "%K == %@", CustomEntryConstants.dayReferenceKey, dayID)
        CloudKitController.shared.fetchRecords(ofType: CustomEntryConstants.customTypeKey, withPredicate: dayPreicate) { (records) in
            if let records = records {
                var entries: [CustomEntry] = []
                let entry = records.compactMap({CustomEntry(record: $0, day: day)})
                entries.append(contentsOf: entry)
                self.customEntries = entries.first
                print("Custom Entries Fetched on CustomEntryController")
                completion(entries.first)
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
