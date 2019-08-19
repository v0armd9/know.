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
    
    //Designated Initializer
    init(happy: Bool = false, sensitive: Bool = false, sad: Bool = false, depressed: Bool = false, nervous: Bool = false, irritated: Bool = false, content: Bool = false, moodSwings: Bool = false, angry: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
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
}
