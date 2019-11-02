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
    
    
    @State private var newReminder = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add New Reminder")) {
                    VStack {
                        HStack {
                            TextField("Reminder", text: self.$newReminder)
                                .font(.headline)
                            Button(action: {
                                let reminder = Reminder(context: self.managedObjectContext)
                                reminder.title = self.newReminder
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    print(error)
                                }
                                
                            }) {
                                Image(systemName: "plus.circle")
                                    .imageScale(.large)
                            }
                        }
                        DatePicker(selection: $date){Text("")}
                    }
                    Section(header: Text("Upcoming Reminders")) {
                        ForEach (reminders) { reminder in
                            ReminderView(title: reminder.title!, time: Date(), details: "")
                        }.onDelete { indexSet in
                            let deletedReminder = self.reminders[indexSet.first!]
                            self.managedObjectContext.delete(deletedReminder)
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("My Reminders")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
