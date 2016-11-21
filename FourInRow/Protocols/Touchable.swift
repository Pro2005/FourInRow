//
//  Touchable.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/21/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import Foundation
import SpriteKit

protocol Touchable {
    
    func touchDown(atPoint pos : CGPoint);
    func touchMoved(toPoint pos : CGPoint);
    func touchUp(atPoint pos : CGPoint);
    
}
