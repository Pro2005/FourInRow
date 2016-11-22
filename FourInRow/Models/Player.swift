//
//  Player.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/22/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation
import UIKit

struct Player {
    let name: String
    let color: UIColor
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
    
}
