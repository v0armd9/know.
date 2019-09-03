//
//  Notifications.swift
//  know.
//
//  Created by Madison Kaori Shino on 9/3/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationController {
 
   static let shared = NotificationController()
    
    func scheduleUpcomingPeriodAlert() {
        guard let user = UserController.shared.currentUser,
            let lastCycleEnd = user.cycles.last?.cycleEndDate
        else { return }
        let noticicationDate = Calendar.current.date(byAdding: .day, value: -2, to: lastCycleEnd)!
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: noticicationDate)
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Your period is expected to start within the next few days"
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "upcomingPeriod", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func scheduleLatePeriodAlert() {
        guard let user = UserController.shared.currentUser,
            let lastCycleEnd = user.cycles.last?.cycleEndDate
            else { return }
        let lateDate = Calendar.current.date(byAdding: .day, value: 3, to: lastCycleEnd)!
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: lateDate)
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Your period is late, let us Know. when it starts"
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "latePeriod", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func cancelUpcomingPeriodAlert() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["upcomingPeriod"])
    }
    
    func cancelLatePeriodAlert() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["latePeriod"])
    }
}
