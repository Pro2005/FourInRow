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
    static let emptyCell            = 0
    static let lengthForWinning     = 4
}

struct Game {
    let size: CGSize!
    var currentPlayer: Player
    // MARK: Private
    private var players: [Player]
    private var field: Matrix<Int>
    
    // MARK: Initialization
    
    init(size: CGSize, players: [Player]) {
        assert(players.count != 0)
        self.size = size
        field = Matrix<Int>(row: Int(size.height), column: Int(size.width), initValue: Constants.emptyCell)
        self.players = players
        currentPlayer = players.first!
    }
    
    // MARK: Public
    
    mutating func addNewCellInColumn(columnNumber: Int) -> Int{
        var rowIndex = 0
        for item in field.itemsInColumn(columnNumber) {
            if item == Constants.emptyCell {
                break;
            }
            rowIndex += 1
        }
        field[rowIndex, columnNumber] = getCurrentPlayerIndex()
        field.printDebug()
        return rowIndex
    }
    
    func shouldAddNewCellInColumn(columnNumber: Int) -> Bool {
        return !isColumnFull(columnNumber: columnNumber)
    }
    
    mutating func nextPlayer() {
        let index = players.index { (player) -> Bool in
            return player == currentPlayer
        }
        guard var currentIndex = index else {
            return
        }
        currentIndex += 1
        if currentIndex >= players.count {
            currentIndex = 0
        }
        currentPlayer = players[currentIndex]
    }
    
    func isCurrentPlayerWinnerWithLast(row: Int, column: Int) -> Player? {
        let rowIterator = RowIterator<Int>(matrix: field, row: row)
        var length = getLineLengthWith(iterator: rowIterator, countableIndex: getCurrentPlayerIndex())
        if length >= Constants.lengthForWinning  {
            return currentPlayer
        }
        
        let columnIterator = ColumnIterator<Int>(matrix: field, column: column)
        length = getLineLengthWith(iterator: columnIterator, countableIndex: getCurrentPlayerIndex())
        if length >= Constants.lengthForWinning {
            return currentPlayer;
        }
        
        let leftToRightIterator = DiagonalLeftToRightIterator<Int>(matrix: field, row: row, column: column)
        length = getLineLengthWith(iterator: leftToRightIterator, countableIndex: getCurrentPlayerIndex())
        if length >= Constants.lengthForWinning {
            return currentPlayer;
        }
        
        let rightToLeftIterator = DiagonalRightToLeftIterator<Int>(matrix: field, row: row, column: column)
        length = getLineLengthWith(iterator: rightToLeftIterator, countableIndex: getCurrentPlayerIndex())
        if length >= Constants.lengthForWinning {
            return currentPlayer;
        }
        
        return nil
    }
    
    mutating func reset() {
        field = Matrix<Int>(row: Int(size.height), column: Int(size.width), initValue: Constants.emptyCell)
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
            return index + 1
        }
        return Constants.emptyCell
    }
    
    private func getLineLengthWith(iterator: MatrixIterator<Int>, countableIndex: Int) -> Int {
        var lenght = 0
        var longestLength = 0
        while let item = iterator.next() {
            if item == countableIndex {
                lenght += 1
            } else {
                if lenght > longestLength {
                    longestLength = lenght
                }
                lenght = 0
            }
        }

        return longestLength
    }
    
}
