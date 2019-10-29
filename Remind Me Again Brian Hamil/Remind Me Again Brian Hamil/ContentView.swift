//
//  ContentView.swift
//  Remind Me Again Brian Hamil
//
//  Created by user159467 on 10/22/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Reminder.getAllReminders()) var reminders: FetchedResults<Reminder>
    
    @State private var newReminderTitle = ""
    @State private var newReminderDetails = ""
    @State private var newReminderTime = 0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add New Reminder")) {
                    HStack {
                        VStack {
                            TextField("New Reminder", text: self.$newReminderTitle)
                            TextField("Reminder Details", text: self.$newReminderDetails)
                            
                        }
                        Button(action: {
                            self.makeNewReminder(newReminderTitle: self.newReminderTitle, newReminderDetails: self.newReminderDetails)
                        }) {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                        }
                    }
                }
                Section(header: Text("Upcoming Reminders")) {
                    ForEach(self.reminders) { reminder in
                        ReminderView(title: reminder.title!, details: reminder.details!)
                    }.onDelete {indexSet in
                        let deleteItem = self.reminders[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("My Reminders"))
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func makeNewReminder(newReminderTitle: String, newReminderDetails: String) {
        
        do {
            try self.managedObjectContext.save()
        }
        catch {
            print(error)
        }
        
        setNewReminder(title: newReminderTitle, body: newReminderDetails, sound: .default, time: 5, repeatReminder: false)
        
        self.newReminderTitle = ""
        self.newReminderDetails = ""
    }
    
    func setNewReminder(title: String, body: String, sound: UNNotificationSound, time: Double, repeatReminder: Bool) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = body
        content.sound = sound
        if time >= 60 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: repeatReminder)
            let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
            center.add(request) { (error) in if error != nil { print(error?.localizedDescription ?? "error local notification")}}
        }
        else {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
    
            center.add(request) { (error) in if error != nil { print(error?.localizedDescription ?? "error local notification")}}
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
