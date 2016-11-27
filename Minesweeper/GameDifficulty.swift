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
    
    //https://media.giphy.com/media/3oz8xLd9DJq2l2VFtu/giphy.gif
    var size: (columns: Int, rows: Int) {
        switch rawValue {
        case 1...2:
            return (6, 6)
        case 3...8:
            return (8, 8)
        case 9...20:
            return (10, 10)
        default:
            return (12, 12)
        }
    }
    
    //https://media.giphy.com/media/3oz8xLd9DJq2l2VFtu/giphy.gif
    var mines: Int {
        switch rawValue {
        case 1:
            return 4
        case 2:
            return 6
        case 3...5:
            return 8
        case 5...8:
            return 10
        case 9...14:
            return 12
        case 15...17:
            return 14
        case 18...19:
            return 16
        case 20...24:
            return 18
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
