//
//  DayController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class DayController {
    
    static let shared = DayController()
    var days: [Day] = []
    
    func saveDay(forUser user: User, date: Date, completion: @escaping(Day?) -> Void) {
        let day = Day(user: user, date: date)
        let record = CKRecord(day: day)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let day = Day(record: record, user: user) else { return }
                print("Day Saved on DayController")
                completion(day)
            }
        }
    }
    
    func fetchDays(forUser user: User, completion: @escaping([Day]?) -> Void) {
        let predicate = NSPredicate(value: true)
        CloudKitController.shared.fetchRecords(ofType: DayConstants.dayTypeKey, withPredicate: predicate) { (records) in
            if let records = records {
                var days: [Day] = []
                let day = records.compactMap({Day(record: $0, user: user)})
                days.append(contentsOf: day)
                print("Days Fetched on DayController")
                completion(days)
            }
        }
    }
    
    func deleteDay(forDay day: Day, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: day.ckRecordID) { (success) in
            if success {
                print("Day Deleted on the DayController")
                completion(true)
            }
        }
    }
}
