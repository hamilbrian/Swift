//
//  Deck.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/2/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

struct Deck: Codable {
    let id: UUID
    let title: String
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case id = "identifier"
        case title = "name"
        case cards
    }
}
