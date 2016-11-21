//
//  GameScene.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/18/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import SpriteKit
import GameplayKit

struct GameSettings {
    static let playingFieldSize = CGSize(width: 10, height: 10)
    static let playingFieldInsets = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
}

class GameScene: SKScene {
    
    // MARK: Lazy properties
    
    private lazy var playingField: PlayingField? = {
        [weak self] in
        guard let weakSelf = self else {
            return nil
        }
        let width = weakSelf.size.width - GameSettings.playingFieldInsets.left - GameSettings.playingFieldInsets.right
        let height = weakSelf.size.height - GameSettings.playingFieldInsets.top - GameSettings.playingFieldInsets.bottom
        let x = GameSettings.playingFieldInsets.left + width / 2.0
        let y = GameSettings.playingFieldInsets.bottom + height / 2.0

        var playingField = PlayingField(size: CGSize(width: width, height: height), numberCells: GameSettings.playingFieldSize);
        playingField.position = CGPoint(x: x, y: y)
        return playingField
    }()
    var touchableObjects = [Touchable]()
    
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
        
    }
    
}
