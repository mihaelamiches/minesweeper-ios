//
//  Game.swift
//  Minesweeper
//
//  Created by Mihaela Miches on 11/26/16.
//  Copyright © 2016 me. All rights reserved.
//

import SpriteKit

class Game {
    let difficulty: GameDifficulty
    var isOver: Bool
    var mines: Grid<Bool>
    var board: Grid<Tile>
    
    init(difficulty: GameDifficulty) {
        self.difficulty = difficulty
        self.isOver = false
        self.mines =  Grid<Bool>(columns: difficulty.size.columns, rows: difficulty.size.rows)
        self.board = Grid<Tile>(columns: difficulty.size.columns, rows: difficulty.size.rows)
        addTiles()
    }
    
    func addTiles() {
        for row in 0..<difficulty.size.rows {
            for column in 0..<difficulty.size.columns {
                board[column, row] = Tile(.unrevealed)
            }
        }
    }
    
    func revealAllTiles() {
        for row in 0..<difficulty.size.rows {
            for column in 0..<difficulty.size.columns {
                if let _ = mines[column, row] {
                    board[column, row] = Tile(.bomb)
                } else if let tileType = board[column, row]?.tileType, tileType == .unrevealed {
                    board[column, row] = Tile(.empty)
                }
            }
        }
    }
    
    func addMines(around position: GridPosition) {
        while mines.count() < difficulty.mines {
            let row = Int(arc4random_uniform(UInt32(difficulty.size.rows)))
            let column = Int(arc4random_uniform(UInt32(difficulty.size.columns)))
            if mines[column, row] == nil && !(row == position.row && column == position.column) {
                mines[column, row] = true
            }
        }
    }
    
    func play(at position: GridPosition) {
        if mines.count() == 0 {
            addMines(around: position)
        }
        
        let isFlagged = (board[position]?.tileType ?? .unrevealed) == .flagged
        
        if mines[position] != nil && !isFlagged {
            isOver = true
            revealAllTiles()
            return
        }
        
        revealTiles(from: position)
        
        if isWon {
            isOver = true
        }
    }
    
    var isWon: Bool {
        let unrevealed = board.count { tile  in
            guard let tile = tile else { return false }
            return tile.tileType == .unrevealed || tile.tileType == .flagged
        }
        
        return unrevealed == mines.count()
    }
    
    func toggleFlag(at position: GridPosition) {
        if let tile = board[position], tile.tileType == .flagged {
            board[position] = Tile(.unrevealed)
        } else {
            board[position] = Tile(.flagged)
        }
    }
    
    func revealTiles(from position: GridPosition) {
        guard let tile = board[position], tile.tileType == .unrevealed, mines[position] == nil else { return }
        
        let sourroundingBombs = bombs(around: position)
        if sourroundingBombs == 0 {
            board[position] = Tile(.empty)
            Direction.all.forEach { direction in
                let neighbour = GridPosition(position.column + direction.offset.column, position.row + direction.offset.row)
                guard 0..<difficulty.size.columns ~= neighbour.column,
                    0..<difficulty.size.rows ~= neighbour.row else { return }
                revealTiles(from: neighbour)
            }
        } else {
            board[position] = Tile(.numbered(sourroundingBombs))
        }
    }
    
    func bombs(around position: GridPosition) -> Int {
        return Direction.all.reduce(0, { (partial, current) -> Int in
            let neighbour = GridPosition(position.column + current.offset.column, position.row + current.offset.row)
            guard 0..<difficulty.size.columns ~= neighbour.column,
                0..<difficulty.size.rows ~= neighbour.row else { return partial }
            
            return mines[neighbour] == nil ? partial : partial+1
        })
    }
}
