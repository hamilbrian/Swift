//
//  GameSave.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/7/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

struct gameSave: Codable {
    let id: String
    var puzzleSize: Int
}

extension gameSave {
    static var defaultGameSave: gameSave {
        return gameSave(id: "save", puzzleSize: 2)
    }
}
