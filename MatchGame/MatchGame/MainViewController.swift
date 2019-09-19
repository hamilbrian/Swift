//
//  MainViewController.swift
//  MatchGame
//
//  Created by Hamil, Brian (UMSL-Student) on 9/17/19.
//  Copyright © 2019 Hamil, Brian (UMSL-Student). All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMainMenu()
    }
    
    func showMainMenu() {
        
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
    
    @objc func playPressed() {

    }
    
    @objc func optionsPressed() {

    }
}
