//
//  ColumnIterator.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/23/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation

class ColumnIterator<T>: MatrixIterator<T> {
    let elements: [T]
    var index = 0
    
    init(matrix: Matrix<T>, column: Int) {
        elements = matrix.itemsInColumn(column)
        super.init()
    }
    
    override func next() -> T? {
        if index >= elements.count {
            return nil
        }
        let item = elements[index]
        index += 1
        return item
    }
    
}
