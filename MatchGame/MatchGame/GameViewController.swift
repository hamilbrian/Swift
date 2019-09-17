//
//  GameViewController.swift
//  MatchGame
//
//  Created by Hamil, Brian (UMSL-Student) on 9/17/19.
//  Copyright © 2019 Hamil, Brian (UMSL-Student). All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

// This code was from the base game kit supplied by Xcode, may not need
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        
        let PlayButton = UIButton()
        let OptionsButton = UIButton()
        
        PlayButton.frame = CGRect(x: self.view.center.x - CGFloat(50), y: self.view.center.y - CGFloat(25), width: CGFloat(100), height: CGFloat(50))
        PlayButton.backgroundColor = UIColor.red
        PlayButton.setTitle("Play", for: .normal)
        PlayButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        self.view.addSubview(PlayButton)
        
        OptionsButton.frame = CGRect(x: PlayButton.center.x - CGFloat(50), y: PlayButton.center.y + CGFloat(50), width: CGFloat(100), height: CGFloat(50))
        OptionsButton.backgroundColor = UIColor.blue
        OptionsButton.setTitle("Options", for: .normal)
        OptionsButton.addTarget(self, action: #selector(optionsPressed), for: .touchUpInside)
        self.view.addSubview(OptionsButton)
        
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func playPressed() {
        print("Play")
    }
    
    @objc func optionsPressed() {
        print("Options")
    }
}
