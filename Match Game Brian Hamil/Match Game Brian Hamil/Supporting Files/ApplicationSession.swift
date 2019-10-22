//
//  ApplicationSession.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/7/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

// Application Session singleton
class ApplicationSession {
    
    static let sharedInstance = ApplicationSession()
    
    var persistence: GameSavePersistenceInterface?
    
    private init() {
        if let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "MatchGame"),
            let persistence = GameSavePersistence(atUrl: appStorageUrl, withDirectoryName: "gameSaves") {
            self.persistence = persistence
        }
    }
}
