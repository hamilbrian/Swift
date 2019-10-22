//
//  JsonCodingKeys.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/7/19.
//  Copyright © 2019 user159467. All rights reserved.
//

struct JsonCodingKey: CodingKey {
    var stringValue: String
    
    init(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
