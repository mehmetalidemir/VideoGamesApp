//
//  LocalNotificationManager.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 20.01.2023.
//

import UserNotifications

final class LocalNotificationManager {

    static let shared = LocalNotificationManager()

    private init() { }

    func requestAccessFromUser() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted: Bool, error: Error?) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            if granted {
                print("Permission granted")
            } else {
                print("Permission not granted")
            }
        }

        //actions defination
        let action1 = UNNotificationAction(identifier: "action1", title: "Action First", options: [.foreground])

        let category = UNNotificationCategory(identifier: "actionCategory", actions: [action1], intentIdentifiers: [], options: [])

        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

    func sendNotification() {

        let content = UNMutableNotificationContent()
        let requestIdentifier = "newNoteNotification"

        content.badge = 1
        content.title = "New note".localized()
        content.body = "New note successfully added".localized()
        content.categoryIdentifier = "actionCategory"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)

        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error: Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "some unknown error")
            }
            print("Notification Register Success")
        }
    }
}
