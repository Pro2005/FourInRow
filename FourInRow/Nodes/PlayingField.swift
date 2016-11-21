//
//  PlayingField.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/18/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import SpriteKit

private struct Constants {
    static let backgroundColor              = UIColor.green
    static let lineWidht: CGFloat           = 1.0
    static let lineColor                    = UIColor.white
}

class PlayingField: SKSpriteNode {

    // MARK: Initializers
    
    init(size: CGSize, cellSize: CGSize) {
        super.init(texture: nil, color: Constants.backgroundColor, size: size)
        
        addNet(size: cellSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }

    func touchMoved(toPoint pos : CGPoint) {

    }

    func touchUp(atPoint pos : CGPoint) {

    }
    
    // MARK: Private
    
    private func addNet(size: CGSize) {
        addVerticalLine(x: 0);
        
        let cellSize = CGSize(width: self.frame.size.width / size.width, height: self.frame.size.height / size.height)
        
        for i in 0 ... Int(size.width) {
            addVerticalLine(x: CGFloat(i) * cellSize.width)
        }
        for i in 0 ... Int(size.height) {
            addHorizontalLine(y: CGFloat(i) * cellSize.height)
        }
    }
    
    private func addVerticalLine(x: CGFloat) {
        let position = CGPoint(x: x + self.frame.origin.x, y: self.frame.origin.y)
        let rect = CGRect(origin: position, size: CGSize(width: Constants.lineWidht, height: self.frame.size.height))
        let line = createLine(rect: rect)
        addChild(line)
    }
    
    private func addHorizontalLine(y: CGFloat) {
        let position = CGPoint(x: self.frame.origin.x, y: y + self.frame.origin.y)
        let rect = CGRect(origin: position, size: CGSize(width: self.frame.size.width, height: Constants.lineWidht))
        let line = createLine(rect: rect)
        addChild(line)
    }
    
    private func createLine(rect: CGRect) -> SKShapeNode {
        let line = SKShapeNode(rect: rect)
        line.fillColor = Constants.lineColor
        line.lineWidth = 0
        return line
    }
    
}
