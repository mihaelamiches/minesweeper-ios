//
//  GameDifficulty.swift
//  Minesweeper
//
//  Created by Mihaela Miches on 11/27/16.
//  Copyright © 2016 me. All rights reserved.
//

import Foundation

enum GameDifficulty: CustomStringConvertible {
    case level(Int)
    
    var description: String {
        return NSLocalizedString("\(self)", comment: "")
    }
    
    var rawValue: Int {
        switch self {
        case .level(let value): return value
        }
    }
    
    var size: (columns: Int, rows: Int) {
        switch self {
        case .level(1):
            return (9, 9)
        case .level(2):
            return (10, 11)
        case .level(3):
            return (10, 14)
        default:
            return (11, 15)
        }
    }
    
    var mines: Int {
        switch self {
        case .level(1):
            return 10
        case .level(2):
            return 16
        case .level(3):
            return 26
        default:
            return 35
        }
    }
}
