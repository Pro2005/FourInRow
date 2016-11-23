//
//  Matrix.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/22/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation

struct Matrix <T> {
    private var items = [[T]]()
    
    
    
    init(row: Int, column: Int, initValue: T) {
        for _ in 0..<row {
            let row = [T](repeatElement(initValue, count: column))
            items.append(row)
        }
    }
    
    // MARK: Public
    
    func printDebug() {
        for row in items {
            print(row, separator: "|", terminator: "\n")
        }
        print("")
    }
    
    func itemsInColumn(_ columnNumber: Int) -> [T] {
        var result = [T]()
        for row in items {
            if columnNumber < row.count {
                result.append(row[columnNumber])
            }
        }
        return result
    }
    
    // MARK: Subscript
    
    public subscript(row: Int, column: Int) -> T {
        get {
            return items[row][column];
        }
        set {
            items[row][column] = newValue;
        }
    }
    
}
