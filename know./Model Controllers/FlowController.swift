//
//  FlowController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class FlowController {
    
    static let shared = FlowController()
    var flows: [Flow] = []
    
    func saveFlowDetails(forDay day: Day, spotting: Bool, light: Bool, medium: Bool, heavy: Bool, completion: @escaping (Bool) -> Void) {
        let flow = Flow(day: day, spotting: spotting, light: light, medium: medium, heavy: heavy)
        let record = CKRecord(flow: flow)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let flowDetail = Flow(record: record, day: day) else { return }
                self.flows.append(flowDetail)
                print("Flow Saved On FlowController")
                completion(true)
            }
        }
    }
    
    func fetchFlowDetails(forDay day: Day, completion: @escaping(Flow?) -> Void) {
        let dayID = day.ckRecordID
        let dayPredicate = NSPredicate(format: "%K == %@", FlowConstants.dayReferenceKey, dayID)
//        guard let flowDetailsID = day.flowDetails?.ckRecordID else { return }
//        let avoidDuplicatePred = NSPredicate(format: "NOT(recordID IN %@)", flowDetailsID)
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dayPredicate, avoidDuplicatePred])
        CloudKitController.shared.fetchRecords(ofType: FlowConstants.flowTypeKey, withPredicate: dayPredicate) { (records) in
            if let records = records {
                var flows: [Flow] = []
                let flow = records.compactMap({Flow(record: $0, day: day)})
                flows.append(contentsOf: flow)
                print("Flows Fetched On FlowController")
                completion(flows.first)
            } else {
                print("Error Fetching Flow")
                completion(nil)
            }
        }
    }
    
    func update(flow: Flow, withSpotting spotting: Bool, light: Bool, medium: Bool, heavy: Bool, completion: @escaping (Bool) -> Void) {
        flow.spotting = spotting
        flow.light = light
        flow.medium = medium
        flow.heavy = heavy
        let record = CKRecord(flow: flow)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("Flow Updated On FlowController")
                completion(true)
            } else {
                print("Flow Failed to Update On FlowController")
                completion(false)
            }
        }
    }
    
    func deleteDetails(forFlow flow: Flow, fromDay day: Day, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: flow.ckRecordID) { (success) in
            if success {
                print("Flow Details Deleted on the FlowController")
                completion(true)
            }
        }
    }
}
