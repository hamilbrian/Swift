//
//  ContentView.swift
//  Remind Me Again Brian Hamil
//
//  Created by user159467 on 10/22/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            Button(action: {
                let center = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                content.title = "New Reminder"
                content.body = "This is a new push notification"
                content.sound = .default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
                
                let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
                
                center.add(request) { (error) in if error != nil { print(error?.localizedDescription ?? "error local notification")}}
                
            }) {
                Text("Add a new notification")
            }
            Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
