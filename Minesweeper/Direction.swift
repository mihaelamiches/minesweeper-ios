//
//  Direction.swift
//  Minesweeper
//
//  Created by Mihaela Miches on 11/27/16.
//  Copyright © 2016 me. All rights reserved.
//

import Foundation

typealias Offset = (column: Int, row: Int)

enum Direction {
    case top, topLeft, topRight, bottom, bottomLeft, bottomRight, left, right
    
    var offset: Offset {
        switch self {
        case .top: return Offset(0,-1)
        case .topLeft: return Offset(-1, -1)
        case .topRight: return Offset(1, -1)
        case .left: return Offset(-1, 0)
        case .right: return Offset(1, 0)
        case .bottom: return Offset(0, 1)
        case .bottomLeft: return Offset(-1, 1)
        case .bottomRight: return Offset(1, 1)
        }
    }
    
    public static var all: [Direction] {
        return [.top, .topLeft, .topRight, .bottom, .bottomLeft, .bottomRight, .left, .right]
    }
}
