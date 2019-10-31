//
//  Reminder.swift
//  Remind Me Again Brian Hamil
//
//  Created by user159467 on 10/29/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation
import CoreData

public class Reminder: NSManagedObject, Identifiable {
    @NSManaged public var reminderID: UUID?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var time: Date?
}

extension Reminder {
    static func getAllReminders() -> NSFetchRequest<Reminder> {
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest() as! NSFetchRequest<Reminder>
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
