//
//  Game.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/22/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation
import UIKit

private struct Constants {
    static let emptyCell    = Foundation.NSNotFound
}

struct Game {
    let size: CGSize!
    var currentPlayer: Player
    // MARK: Private
    private var players: [Player]
    private var field: Matrix<Int>
    
    // MARK: Initialization
    
    init(size: CGSize, players: [Player]) {
        assert(players.count == 0)
        self.size = size
        field = Matrix<Int>(row: Int(size.height), column: Int(size.width), initValue: Constants.emptyCell)
        self.players = players
        currentPlayer = players.first!
    }
    
    // MARK: Public
    
    func addNewCellInColumn(columnNumber: Int) {
        var rowIndex: Int = 0
        for item in field.itemsInColumn(columnNumber) {
            if item == Constants.emptyCell {
                break;
            }
            rowIndex += 1
        }
//        self.field[rowIndex, columnNumber] = 10
    }
    
    func shouldAddNewCellInColumn(columnNumber: Int) -> Bool {
        return !isColumnFull(columnNumber: columnNumber)
    }
    
    
    // MARK: Private
    
    private func isColumnFull(columnNumber: Int) -> Bool {
        var isFull = true
        for item in field.itemsInColumn(columnNumber) {
            if item == Constants.emptyCell {
                isFull = false
                break
            }
        }
        return isFull
    }
    
    private func getCurrentPlayerIndex() -> Int {
        let index = self.players.index { (player) -> Bool in
            return player == currentPlayer
        }
        if let index = index {
            return index
        }
        return Constants.emptyCell
    }
    
}
