//
//  GameScene.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/18/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import SpriteKit
import GameplayKit

private struct Constants {
    static let playingFieldInsets = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
}

class GameScene: SKScene {
    private let playingFieldSize: CGSize!
    let game: Game!
    
    // MARK: Lazy properties
    
    private lazy var playingField: PlayingField? = {
        [weak self] in
        guard let weakSelf = self else {
            return nil
        }
        let width = weakSelf.size.width - Constants.playingFieldInsets.left - Constants.playingFieldInsets.right
        let height = weakSelf.size.height - Constants.playingFieldInsets.top - Constants.playingFieldInsets.bottom
        let x = Constants.playingFieldInsets.left + width / 2.0
        let y = Constants.playingFieldInsets.bottom + height / 2.0

        var playingField = PlayingField(size: CGSize(width: width, height: height), numberCells: weakSelf.playingFieldSize)
        playingField.position = CGPoint(x: x, y: y)
        return playingField
    }()
    var touchableObjects = [Touchable]()
    
    init(size: CGSize, game: Game) {
        self.playingFieldSize = game.size
        self.game = game
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        addPlayingField()
        if let playingField = playingField {
            playingField.delegate = self
            touchableObjects.append(playingField)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: UIResponder

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchDown(atPoint: touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchMoved(toPoint: touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchUp(atPoint: touch.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchUp(atPoint: touch.location(in: self))
        }
    }
    
    // MARK: Private
    
    private func touchDown(atPoint pos : CGPoint) {
        for object in touchableObjects {
            object.touchDown(atPoint: pos)
        }
    }
    
    private func touchMoved(toPoint pos : CGPoint) {
        for object in touchableObjects {
            object.touchMoved(toPoint: pos)
        }
    }
    
    private func touchUp(atPoint pos : CGPoint) {
        for object in touchableObjects {
            object.touchUp(atPoint: pos)
        }
    }
    
    private func addPlayingField() {
        if let playingField = self.playingField {
            addChild(playingField)
        }
    }
    
}

extension GameScene: PlayingFieldDelegate {
    
    func playingField(_ playingField: PlayingField, didSelectColAt: Int) {
        if !game.shouldAddNewCellInColumn(columnNumber: didSelectColAt) {
            return
        }
        game.addNewCellInColumn(columnNumber: didSelectColAt)
        game.displayInConsole()
    }
    
}
