//
//  Log.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/7/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

struct Log {
    static func error<T>(_ error: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        let text = generateText(type: error, function: function, file: file, atLine: line)
        print("🛑 MatchGame ERROR 🛑 : \(text)")
    }
    
    static func info<T>(_ info: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        let text = generateText(type: info, function: function, file: file, atLine: line)
        print("💚 MatchGame 💚 : \(text)")
    }
    
    private static func generateText<T>(type: T? = nil, function: String? = nil, file: String? = nil, atLine line: Int? = nil) -> String {
        var text = ""
        
        if let fileName = file, let pathElement = fileName.components(separatedBy: "/").last {
            text += "\(pathElement)"
        }
        
        if let lineNum = line {
            text += " [\(lineNum)]"
        }
        
        if var functionName = function {
            if functionName.contains("(") && functionName.contains(")") {
                let characterSet = CharacterSet(charactersIn: "(")
                functionName = functionName.components(separatedBy: characterSet).first ?? functionName
            }
            text += " \(functionName)"
        }
        
        if let sender = type as? String {
            if sender != "" {
                text += " : \(sender)"
            }
        } else if let sender = type {
            text += " : \(sender)"
        }
        
        return text
    }
}
