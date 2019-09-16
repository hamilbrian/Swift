//
//  ViewController.swift
//  Project 1 Brian Hamil
//
//  Created by Hamil, Brian (UMSL-Student) on 9/5/19.
//  Copyright © 2019 Hamil, Brian (UMSL-Student). All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func transitionToViewController() {
        let deckController = DeckViewController()
        deckController.willMove(toParent: self)
        let current = children.first!
        addChild(deckController)
        self.view.addSubview(deckController.view)
        deckController.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.didMove(toParent: nil)
    }

}

