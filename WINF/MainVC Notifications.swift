//
//  MainVC Notifications.swift
//  WINF
//
//  Created by Vatsal Rustagi on 1/9/18.
//  Copyright © 2018 Vatsalr23. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension MainVC{
    func createNotification(item: Items){
        let content = UNMutableNotificationContent()
        content.title = "Your \(item.name!.trimmingCharacters(in: .whitespacesAndNewlines)) has expired."
        
        let newDate = Date(timeIntervalSinceNow: 0)
        let timeInterval = (item.date!).timeIntervalSince(newDate)
        var trigger: UNTimeIntervalNotificationTrigger
        
        if timeInterval <= 0{
            let currentHour = Calendar.current.component(.hour, from: Date())
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: (TimeInterval((24.5 - Double(currentHour))*3600)), repeats: false)
        }
        else{
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        
        let notificationUUID = UUID().uuidString
        item.id = notificationUUID
        appDelegate.saveContext()
        
        let request = UNNotificationRequest(identifier: notificationUUID, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
