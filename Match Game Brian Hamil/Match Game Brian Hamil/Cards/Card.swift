//
//  Card.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/2/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

struct Card: Codable, Equatable {
    let front: String
    let back: String
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.front == rhs.front &&
        lhs.back == rhs.back
}
