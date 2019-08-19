//
//  Sex.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/19/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Sex {
    
    //Class Objects
    var protected: Bool
    var sexDrive: Bool
    var masturbation: Bool
    var ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(protected: Bool = false, sexDrive: Bool = false, masturbation: Bool = false, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.protected = protected
        self.sexDrive = sexDrive
        self.masturbation = masturbation
        self.ckRecordID = ckRecordID
    }
}
