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
    private var playingField: PlayingField = {
        [weak self] in
//        let width = self.size.width - GameSettings.playingFieldInsets.left - GameSettings.playingFieldInsets.right
//        let height = self.size.height - GameSettings.playingFieldInsets.top - GameSettings.playingFieldInsets.bottom
//        let x = GameSettings.playingFieldInsets.left + width / 2.0
//        let y = GameSettings.playingFieldInsets.bottom + height / 2.0
//        
//        playingField = PlayingField(size: CGSize(width: width, height: height), cellSize: GameSettings.playingFieldSize);
//        playingField.position = CGPoint(x: x, y: y)
    }()
    
    // MARK: Lifecycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.addPlayingField()
        
    }
    
    // MARK: Private 
    
    private func addPlayingField() {
        let width = self.size.width - GameSettings.playingFieldInsets.left - GameSettings.playingFieldInsets.right
        let height = self.size.height - GameSettings.playingFieldInsets.top - GameSettings.playingFieldInsets.bottom
        let x = GameSettings.playingFieldInsets.left + width / 2.0
        let y = GameSettings.playingFieldInsets.bottom + height / 2.0
    
        playingField = PlayingField(size: CGSize(width: width, height: height), cellSize: GameSettings.playingFieldSize);
        playingField.position = CGPoint(x: x, y: y)
        addChild(playingField)
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }

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

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
