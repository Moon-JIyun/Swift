//
//  UNNotificationCenter.swift
//  drinkWaterAlarm
//
//  Created by jiyun moon on 2022/05/13.
//

import Foundation
import UserNotifications
import UIKit

extension UNUserNotificationCenter {
    
    func addNotificationRequest(by alert: Alert) {
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에요 💦"
        content.body = "세계 보건기구가 권장하는 하루 물 섭취량은 1.5~2리터 입니다."
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
