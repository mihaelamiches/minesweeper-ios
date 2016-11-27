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
        return NSLocalizedString("level \(self.rawValue)", comment: "")
    }
    
    var rawValue: Int {
        switch self {
        case .level(let value): return value
        }
    }
    
    var size: (columns: Int, rows: Int) {
        switch rawValue {
        case 1:
            return (6, 6)
        case 2...8:
            return (8, 8)
        case 9...20:
            return (10, 10)
        default:
            return (12, 12)
        }
    }
    
    var mines: Int {
        switch rawValue {
        case 1:
            return 6
        case 2...4:
            return 8
        case 5...8:
            return 12
        case 9...20:
            return 20
        default:
            return max(rawValue/2, 24)
        }
    }
    
    static var last: GameDifficulty {
        get {
            let lvl = UserDefaults.standard.integer(forKey: "lvl")
            return 1...80 ~= lvl ? .level(lvl) : .level(1)
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "lvl")
        }
    }
}
