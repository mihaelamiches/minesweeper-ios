//
//  Extensions.swift
//  Minesweeper
//
//  Created by Mihaela Miches on 11/26/16.
//  Copyright © 2016 me. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    static func tile(_ type: TileType, ofSize tileSize: CGFloat) -> SKShapeNode {
        let nodeSize = CGSize(width: tileSize, height: tileSize)
        let tileNode = SKShapeNode(rectOf: nodeSize)
        tileNode.strokeColor = .lightGray
        
        let detail = SKLabelNode(text: "\(type.description)")
        detail.fontSize = tileSize*2/3
        detail.position = CGPoint(x: 0, y: -tileSize/4)
        tileNode.addChild(detail)
        
        switch type {
        case .flagged, .unrevealed: 
            tileNode.fillColor = .gray
        default:
            break;
        }
        return tileNode
    }
    
    static func highlightedTile(ofSize size: CGFloat) -> SKShapeNode{
        let nodeSize = CGSize(width: size, height: size)
        let tileNode = SKShapeNode(rectOf: nodeSize)
        tileNode.strokeColor = .red
        return tileNode
    }
}
