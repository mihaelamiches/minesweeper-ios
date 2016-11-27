//
//  Extensions.swift
//  Minesweeper
//
//  Created by Mihaela Miches on 11/26/16.
//  Copyright © 2016 me. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    static func tile(_ type: TileType, ofSize tileSize: CGFloat, colorTheme: ColorTheme) -> SKShapeNode {
        let nodeSize = CGSize(width: tileSize, height: tileSize)
        let tileNode = SKShapeNode(rectOf: nodeSize)
        tileNode.strokeColor = .lightGray
        
        let detail = SKLabelNode(text: "\(type.description)")
        detail.fontSize = tileSize*2/3
        if type != .bomb && type != .empty && type != .flagged && type != .unrevealed {
           detail.fontColor = colorTheme[type.hashValue]
        }
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

let phi: CGFloat = 1.618
typealias ColorTheme = [UIColor]

extension UIColor {
    static var random: UIColor {
        let hue1 = CGFloat(arc4random_uniform(UInt32(254)))
        let hue2 = hue1 * phi
        let hue3 = hue2 * phi
        
        let colorValues: [CGFloat] = [hue1, hue2, hue3].sorted {_, _ in arc4random() % 2 == 0}.map {$0/255}
        
        return UIColor(red: colorValues[0], green: colorValues[1], blue: colorValues[2], alpha: 1)
    }
    
    static func colorTheme(colors count: Int) -> ColorTheme {
        var themeColors = [UIColor]()
        for _ in 0..<count {
            themeColors.append(UIColor.random)
        }
        return themeColors
    }
}
