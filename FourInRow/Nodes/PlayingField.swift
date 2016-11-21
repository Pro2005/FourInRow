//
//  PlayingField.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/18/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import SpriteKit

protocol PlayingFieldDelegate {
    func playingField(_ playingField: PlayingField, didSelectColAt: Int)
}

private struct Constants {
    static let backgroundColor              = UIColor.black
    static let lineWidht: CGFloat           = 1
    static let lineColor                    = UIColor.white
}

class PlayingField: SKSpriteNode {
    var delegate: PlayingFieldDelegate?
    var numberCells: CGSize!

    // MARK: Initializers
    
    init(size: CGSize, numberCells: CGSize) {
        super.init(texture: nil, color: Constants.backgroundColor, size: size)
        
        self.numberCells = numberCells
        addNet(size: numberCells)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension PlayingField: Touchable {
    
    func touchDown(atPoint pos : CGPoint) {
        if let col = getColNumber(by: pos) {
            delegate?.playingField(self, didSelectColAt: col)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    // MARK: Private
    
    private func getColNumber(by position: CGPoint) -> Int? {
        if !contains(position) {
            return nil
        }
        let localPosition = CGPoint(x: floor(position.x) - self.frame.origin.x, y: floor(position.y) - self.frame.origin.y)
        let cellWidth = (frame.size.width / numberCells.width)
        let col = localPosition.x / cellWidth
        return Int(col)
    }
    
}
