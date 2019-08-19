//
//  Flow.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Flow {
    
    //Class Objects
    var spotting: Bool
    var light: Bool
    var medium: Bool
    var heavy: Bool
    var ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(spotting: Bool = false, light: Bool = false, medium: Bool = false, heavy: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.spotting = spotting
        self.light = light
        self.medium = medium
        self.heavy = heavy
        self.ckRecordID = ckRecordID
    }
    
    //Convenience initializer (Record to a class object)
//    convenience init?()
    
    
    
    
}

//extension
