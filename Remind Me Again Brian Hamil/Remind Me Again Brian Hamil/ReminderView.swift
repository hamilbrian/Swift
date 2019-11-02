//
//  ReminderView.swift
//  Remind Me Again Brian Hamil
//
//  Created by user159467 on 10/29/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import SwiftUI

struct ReminderView: View {
    var title: String = ""
    var time: Date?
    let dateformatter = DateFormatter()
    var details: String = "" // from initial design - not used
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(dateformatter.string(from: time ?? Date()))
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
