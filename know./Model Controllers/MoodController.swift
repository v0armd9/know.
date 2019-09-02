//
//  MoodController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class MoodController {
    
    static let shared = MoodController()
    var moods: Mood?
    
    func saveMoods(forDay day: Day, happy: Bool, sensitive: Bool, sad: Bool, depressed: Bool, nervous: Bool, irritated: Bool, content: Bool, moodSwings: Bool, angry: Bool, completion: @escaping(Bool) -> Void) {
        let mood = Mood(day: day, happy: happy, sensitive: sensitive, sad: sad, depressed: depressed, nervous: nervous, irritated: irritated, content: content, moodSwings: moodSwings, angry: angry)
        let record = CKRecord(mood: mood)
        CloudKitController.shared.save(record: record) { (record) in
            if let record = record {
                guard let mood = Mood(record: record, day: day) else { return }
                self.moods = mood
                print("Mood Saved")
                completion(true)
            }
        }
    }
    
    func fetchMoods(forDay day: Day, completion: @escaping(Mood?) -> Void) {
        let dayID = day.ckRecordID
        let dayPreicate = NSPredicate(format: "%K == %@", MoodConstants.dayReferenceKey, dayID)
        CloudKitController.shared.fetchRecords(ofType: MoodConstants.moodTypeKey, withPredicate: dayPreicate) { (records) in
            if let records = records {
                var moods: [Mood] = []
                let mood = records.compactMap({Mood(record: $0, day: day)})
                moods.append(contentsOf: mood)
                self.moods = moods.first
                print("Moods Fetched")
                completion(moods.first)
            } else {
                print("Error Fetching Moods")
                completion(nil)
            }
        }
    }
    
    func update(mood: Mood, withHappy happy: Bool, sensitive: Bool, sad: Bool, depressed: Bool, nervous: Bool, irritated: Bool, content: Bool, moodSwings: Bool, angry: Bool, completion: @escaping(Bool) -> Void) {
        mood.happy = happy
        mood.sensitive = sensitive
        mood.sad = sad
        mood.depressed = depressed
        mood.nervous = nervous
        mood.irritated = irritated
        mood.content = content
        mood.moodSwings = moodSwings
        mood.angry = angry
        let record = CKRecord(mood: mood)
        CloudKitController.shared.update(record: record) { (success) in
            if success {
                print("Mood Updated on MoodController")
                completion(true)
            } else {
                print("Mood Failed to Update on MoodController")
                completion(false)
            }
        }
    }
    
    func deleteDetails(forMood mood: Mood, fromDay day: Day, completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.delete(recordID: mood.ckRecordID) { (success) in
            if success {
                print("Mood Details Deleted on MoodController")
                completion(true)
            }
        }
    }
}
