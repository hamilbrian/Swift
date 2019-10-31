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

    @State private var date = Date()
    @State private var title = ""
    @State private var detail = ""
    
    var body: some View {
        Section(header: Text("Add New Reminder")) {
            VStack {
                TextField("Title", text: self.$title)
                    .font(.headline)
                TextField("Details", text: self.$detail)
                    .font(.subheadline)
                DatePicker(selection: $date){Text("")}
                Button(action: {
                    self.makeNewReminder()
                }) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
            }
            Section(header: Text("Upcoming Reminders")) {
                ForEach (self.reminders) {reminder in
                    ReminderView(title: self.title, details: self.detail, time: self.date)
                }
            }
            Spacer()
        }
    }
    
    func makeNewReminder() {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = detail
        
        let calendar = Calendar.current
        let components: [Calendar.Component] =
            [.day, .month, .year, .hour, .minute, .second]
        
        var triggerComponents = calendar.dateComponents(Set(components), from: Date())
        triggerComponents.second! += 5
        triggerComponents.era = nil
        triggerComponents.nanosecond = nil
        triggerComponents.weekday = nil
        triggerComponents.weekdayOrdinal = nil
        triggerComponents.quarter = nil
        triggerComponents.yearForWeekOfYear = nil
        triggerComponents.weekOfMonth = nil
        triggerComponents.weekOfYear = nil
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        let newReminder = Reminder(context: self.managedObjectContext)
        newReminder.title = title
        newReminder.details = detail
        newReminder.time = date
        print(newReminder.time)
        
        do
        {
            try self.managedObjectContext.save()
            print("Saved")
        }
        catch {
            print("Error")
        }
        
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let err = error {
                print("Failed to add request: \(err)")
            } else {
                print("Success!!")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
