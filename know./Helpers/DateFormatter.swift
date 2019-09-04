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
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    func formattedDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let formattedDateString = formatter.string(from: self)
        let formattedDate = formatter.date(from: formattedDateString)
        return formattedDate!
    }
    
    func prettyDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d")
        return formatter.string(from: self)
    }
    
    func prettyDateStringShort() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("E MMM d")
        return formatter.string(from: self)
    }
}
