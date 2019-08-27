//
//  LabelHelper.swift
//  know.
//
//  Created by Darin Armstrong on 8/20/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    var overrideAdjustFontBool: Bool = true
    
    override var adjustsFontSizeToFitWidth: Bool {
        get {
            return overrideAdjustFontBool
        } set {
            overrideAdjustFontBool = true
        }
    }
}
