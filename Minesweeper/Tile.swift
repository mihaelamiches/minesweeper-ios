//
//  Tile.swift
//  Minesweeper
//
//  Created by Mihaela Miches on 11/26/16.
//  Copyright © 2016 me. All rights reserved.
//

import SpriteKit

enum TileType: CustomStringConvertible {
    case unrevealed, empty, numbered(Int), flagged, bomb
    
    var description: String {
        switch self {
        case .unrevealed: return ""
        case .empty: return ""
        case .numbered(let value): return "\(value)"
        case .flagged: return "🚩"
        case .bomb: return "💥"
        }
    }
    
    var hashValue: Int {
        switch self {
        case .unrevealed: return Int.min
        case .empty: return 0
        case .numbered(let value): return value
        case .flagged: return -1
        case .bomb: return Int.max
        }
    }
}

func ==(lhs: TileType, rhs: TileType) -> Bool {
   return lhs.hashValue == rhs.hashValue
}

func !=(lhs: TileType, rhs: TileType) -> Bool {
    return lhs.hashValue != rhs.hashValue
}

struct Tile {
    let tileType: TileType
    
    init(_ tileType: TileType) {
        self.tileType = tileType
    }
}
//https://media.giphy.com/media/3oz8xLd9DJq2l2VFtu/giphy.gif
