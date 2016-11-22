//
//  Game.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/22/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation
import UIKit

private enum CellType: Int {
    case empty
}

struct Game {
    let size: CGSize!
    private var field = [[Int]]()
    
    // MARK: Initialization
    
    init(size: CGSize) {
        self.size = size
        setupField(size)
    }
    
    // MARK: Public
    
    func addNewCellInColumn(columnNumber: Int) {
        for row in field.reversed() {
            var cell = row[columnNumber]
            if cell == CellType.empty.rawValue {
            }
        }
    }
    
    func shouldAddNewCellInColumn(columnNumber: Int) -> Bool {
        return !isColumnFull(columnNumber: columnNumber)
    }
    
    func displayInConsole() {
        for row in field {
            print(row, separator: "|", terminator: "\n");
        }
    }
    
    // MARK: Private 
    
    private mutating func setupField(_ size: CGSize) {
        for _ in 0...Int(size.height) {
            var row = [Int]()
            for _ in 0...Int(size.width) {
                let empty = 0
                row.append(empty)
            }
            field.append(row)
        }
    }
    
    private func isColumnFull(columnNumber: Int) -> Bool {
        var isFull = true
        for row in field {
            if columnNumber < row.count {
                let cell = row[columnNumber]
                if cell == CellType.empty.rawValue {
                    isFull = false
                    break
                }
            }
        }
        return isFull
    }
    
}
