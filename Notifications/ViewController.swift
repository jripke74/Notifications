//
//  ViewController.swift
//  Notifications
//
//  Created by Jeff Ripke on 8/8/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleNotification()
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "10 second notification demo"
        content.subtitle = "From Jeff"
        content.body = "Notification after 10 seconds - Your alert is ready!"
        content.badge = 5
        content.sound = UNNotificationSound(named: "laser.caf")
        content.userInfo = ["id": 42]
        let imageURL = Bundle.main.url(forResource: "spaceCat1", withExtension: "png")
        let attachment = try! UNNotificationAttachment(identifier: "spaceCat1.png", url: imageURL!, options: nil)
        content.attachments = [attachment]
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        let request = UNNotificationRequest(identifier: "10.secnond.notification", content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: nil)
        notificationCenter.delegate = self
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("silently handle notification")
        completionHandler([.alert, .sound])
    }
}
