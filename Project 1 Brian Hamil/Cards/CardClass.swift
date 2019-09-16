//
//  CardClass.swift
//  Project 1 Brian Hamil
//
//  Created by Hamil, Brian (UMSL-Student) on 9/16/19.
//  Copyright © 2019 Hamil, Brian (UMSL-Student). All rights reserved.
//

import Foundation

class Card {
    var frontText = String()
    var backText = String()
    
    init(frontText: String, backText: String) {
        self.frontText = frontText
        self.backText = backText
    }
}
