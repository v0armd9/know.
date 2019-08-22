//
//  DateFormatter.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/21/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation

extension Date {
    func stringWith(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
