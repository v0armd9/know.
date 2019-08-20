//
//  Mood.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Mood {
    
    //Class Objects
    var happy: Bool
    var sensitive: Bool
    var sad: Bool
    var depressed: Bool
    var nervous: Bool
    var irritated: Bool
    var content: Bool
    var moodSwings: Bool
    var angry: Bool
    var ckRecordID: CKRecord.ID
    weak var day: Day?
    
    var dayReference: CKRecord.Reference? {
        guard let day = day else { return nil }
        return CKRecord.Reference(recordID: day.ckRecordID, action: .deleteSelf)
    }
    
    //Designated Initializer
    init(day: Day, happy: Bool = false, sensitive: Bool = false, sad: Bool = false, depressed: Bool = false, nervous: Bool = false, irritated: Bool = false, content: Bool = false, moodSwings: Bool = false, angry: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.happy = happy
        self.sensitive = sensitive
        self.sad = sad
        self.depressed = depressed
        self.nervous = nervous
        self.irritated = irritated
        self.content = content
        self.moodSwings = moodSwings
        self.angry = angry
        self.ckRecordID = ckRecordID
    }
    
    //Initialize class object from a record
    convenience init?(record: CKRecord, day: Day) {
        guard let happy = record[MoodConstants.happyKey] as? Bool,
        let sensitive = record[MoodConstants.sensitiveKey] as? Bool,
        let sad = record[MoodConstants.sadKey] as? Bool,
        let depressed = record[MoodConstants.depressedKey] as? Bool,
        let nervous = record[MoodConstants.nervousKey] as? Bool,
        let irritated = record[MoodConstants.irritatedKey] as? Bool,
        let content = record[MoodConstants.contentKey] as? Bool,
        let moodSwings = record[MoodConstants.moodSwingKey] as? Bool,
        let angry = record[MoodConstants.angryKey] as? Bool
            else { return nil }
        self.init(day: day, happy: happy, sensitive: sensitive, sad: sad, depressed: depressed, nervous: nervous, irritated: irritated, content: content, moodSwings: moodSwings, angry: angry, ckRecordID: record.recordID)
    }
}

//Initialize a record from a class object
extension CKRecord {
    convenience init(mood: Mood) {
        self.init(recordType: MoodConstants.moodTypeKey, recordID: mood.ckRecordID)
        self.setValue(mood.happy, forKey: MoodConstants.happyKey)
        self.setValue(mood.sensitive, forKey: MoodConstants.sensitiveKey)
        self.setValue(mood.sad, forKey: MoodConstants.sadKey)
        self.setValue(mood.depressed, forKey: MoodConstants.depressedKey)
        self.setValue(mood.nervous, forKey: MoodConstants.nervousKey)
        self.setValue(mood.irritated, forKey: MoodConstants.irritatedKey)
        self.setValue(mood.content, forKey: MoodConstants.contentKey)
        self.setValue(mood.moodSwings, forKey: MoodConstants.moodTypeKey)
        self.setValue(mood.angry, forKey: MoodConstants.angryKey)
        self.setValue(mood.dayReference, forKey: MoodConstants.dayReferenceKey)
    }
}

//Conform to Equatable for Deletion
extension Mood: Equatable {
    static func ==(lhs: Mood, rhs: Mood) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

//Magic String Constants
struct MoodConstants {
    static let moodTypeKey = "Mood"
    fileprivate static let happyKey = "happy"
    fileprivate static let sensitiveKey = "sensitive"
    fileprivate static let sadKey = "sad"
    fileprivate static let depressedKey = "depressed"
    fileprivate static let nervousKey = "nervous"
    fileprivate static let irritatedKey = "irritated"
    fileprivate static let contentKey = "content"
    fileprivate static let moodSwingKey = "moodSwings"
    fileprivate static let angryKey = "angry"
    fileprivate static let dayReferenceKey = "dayReference"
}
