//
//  URL.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/7/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

extension URL {
    var baseName: String {
        return lastPathComponent.components(separatedBy: ".").dropLast().joined()
    }
}
