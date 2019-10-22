//
//  GameSavePersistance.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/7/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

protocol GameSavePersistenceInterface {
    var gameSaves: [gameSave] { get }
    func save(gameSave: gameSave)
}

final class GameSavePersistence: FileStoragePersistence, GameSavePersistenceInterface {
    
    let directoryUrl: URL
    let fileType: String = "json"
    
    init?(atUrl baseUrl: URL, withDirectoryName name: String) {
        guard let directoryUrl = FileManager.default.createDirectory(atUrl: baseUrl, appendingPath: name) else { return nil }
        self.directoryUrl = directoryUrl
    }
    
    var gameSaves: [gameSave] {
        return names.compactMap() {
            guard let gameSaveData = read(fileWithId: $0) else { return nil }
            
            return try? JSONDecoder().decode(gameSave.self, from: gameSaveData)
        }
    }
    
    func save(gameSave: gameSave) {
        save(object: gameSave, withId: gameSave.id)
    }
}
