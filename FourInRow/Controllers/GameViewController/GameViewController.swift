//
//  GameViewController.swift
//  FourInRow
//
//  Created by Ilya Denisov on 11/18/16.
//  Copyright © 2016 Ilya Denisov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // MARK: Lifecycle
    
    override func loadView() {
        view = SKView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Private
    
    private func setup() {
        let gameScene = self.createGameScene()
        present(scene: gameScene)
        setDebugInfo()
    }
    
    private func createGameScene() -> SKScene {
        let scene = GameScene(size: self.view.frame.size)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    private func setDebugInfo() {
        guard let view = self.view as? SKView else {
            return
        }
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }
    
    private func present(scene: SKScene) {
        if let view = self.view as? SKView {
            view.presentScene(scene)
        }
    }
}
