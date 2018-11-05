//
//  Notification.swift
//  Water
//
//  Created by Юрий Макаров on 02/11/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit
import UserNotifications

class Notification: NSObject, UNUserNotificationCenterDelegate {
    
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func applicationRequestAuthorisationNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .carPlay, .sound], completionHandler: { (grant, error) in
            guard grant else { return }
            print("Granted: \(grant)")
            self.getNotificationCentr()
        })
    }
    
    
    func getNotificationCentr() {
        notificationCenter.getNotificationSettings { (settings) in
            print(settings)
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    /*
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
 */
    
    func scheduleNotificationContent() {
        let idActions = "Actions"
        let content = UNMutableNotificationContent()
        content.title = "Водный мир"
        content.subtitle = "Уведомление от Водного мира"
        content.body = "Вы находитесь рядом с Водным Миром - заходите в гости."
        content.sound = UNNotificationSound.defaultCritical
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        content.categoryIdentifier = idActions
        
        
        let idNotification = "Local Notification"
        
        
        let order = UNNotificationAction(identifier: "order", title: "Заказать водичку", options: .authenticationRequired)
        let cancel = UNNotificationAction(identifier: "cancel", title: "Не буду", options: .destructive)
        
        let category = UNNotificationCategory(identifier: idActions,
                                              actions: [order, cancel],
                                              intentIdentifiers: [],
                                              options: [])
        notificationCenter.setNotificationCategories([category])
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: idNotification,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
}
