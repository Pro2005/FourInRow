//
//  DiagonalLeftToRideIterator.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/23/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation

class DiagonalLeftToRightIterator<T>: MatrixIterator<T> {
    var elements: [T]!
    var index = 0
    
    init(matrix: Matrix<T>, row: Int, column: Int) {
        super.init()

        var elements = [T]()
        var position = getLowestPositionFor(row: row, column: column, matrix: matrix)
        
        while true {
            if position.x >= matrix.columnCount - 1 {
                break
            }
            if position.y < 0 {
                break
            }
            let item = matrix[position.x, position.y]
            elements.append(item)
            position.x += 1
            position.y -= 1
        }
        
        self.elements = elements
    }
    
    override func next() -> T? {
        if index >= elements.count {
            return nil
        }
        let item = elements[index]
        index += 1
        return item
    }
    
    // MARK: Private
    
    private func getLowestPositionFor(row: Int, column: Int, matrix: Matrix<T>) -> (x: Int, y: Int) {
        var position = (x: column, y: row)
        
        while true {
            if position.x <= 0 {
                break
            }
            if position.y >= matrix.rowCount - 1 {
                break
            }
            position.x -= 1
            position.y += 1
        }
        
        return position
    }
    
}
