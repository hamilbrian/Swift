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
    var details: String = ""
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(details)
                .font(.subheadline)
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
