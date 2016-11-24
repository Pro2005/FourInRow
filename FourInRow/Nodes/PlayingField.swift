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
    var numberCells: CGSize
    var cellSize: CGSize!
    var bubbles = [SKShapeNode]()

    // MARK: Initializers
    
    init(size: CGSize, numberCells: CGSize) {
        self.numberCells = numberCells
        super.init(texture: nil, color: Constants.backgroundColor, size: size)
        cellSize = CGSize(width: self.frame.size.width / numberCells.width, height: self.frame.size.height / numberCells.height)
        addNet(size: numberCells)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    func addBubble(color: UIColor, row: Int, column: Int) {
        let radius = (cellSize.width > cellSize.height ? cellSize.height : cellSize.width) / 2.0
        let bubble = SKShapeNode(circleOfRadius: radius)
        bubble.fillColor = color
        let position = getCenterPositionBy(row: row, column: column)
        bubble.position = position
        bubbles.append(bubble)
        addChild(bubble)
    }
    
    func reset() {
        for bubble in bubbles {
            bubble.removeFromParent()
        }
        bubbles.removeAll()
    }
    
    // MARK: Private
    
    private func addNet(size: CGSize) {
        addVerticalLine(x: 0);
        
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
    
    private func getCenterPositionBy(row: Int, column: Int) -> CGPoint {
        let x = (CGFloat(column) * cellSize.width + cellSize.width / 2.0) - self.frame.size.width / 2.0
        let y = (CGFloat(row) * cellSize.height + cellSize.height / 2.0) - self.frame.size.height / 2.0
        return CGPoint(x: x, y: y)
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
