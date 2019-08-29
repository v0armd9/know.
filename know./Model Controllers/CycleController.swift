//
//  CycleController.swift
//  know.
//
//  Created by Darin Armstrong on 8/29/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class CycleController {
    
    static let shared = CycleController()
    
    func saveCycle(forUser user: User, cycle: DateInterval, period: DateInterval, completion: @escaping(Cycle?) -> Void) {
        let cycle = Cycle(cycleDateInterval: cycle, periodDateInterval: period, user: user)
        let record = CKRecord(cycle: cycle)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let cycle = Cycle(record: record, user: user) else { return }
                user.cycles.append(cycle)
                print("Cycle saved on User")
                completion(cycle)
            }
        }
    }
    
    func fetchCycles(forUser user: User, completion: @escaping([Cycle]?) -> Void) {
        let predicate = NSPredicate(value: true)
        CloudKitController.shared.fetchRecords(ofType: CycleConstants.recordType, withPredicate: predicate) { (records) in
            if let records = records {
                var cycles: [Cycle] = []
                let cycle = records.compactMap({Cycle(record: $0, user: user)})
                cycles.append(contentsOf: cycle)
                print("Cycles Fetched for User")
                completion(cycles)
            }
        }
    }
    
    func delete(cycle: Cycle, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: cycle.recordID) { (success) in
            if success {
                print("Cycle deleted")
                completion(true)
            }
        }
    }
}
