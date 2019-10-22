//
//  ViewController.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/1/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    
    var gameModel: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameModel = GameModel(delegate: self)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "Game Segue", sender: self)
    }
    
    @IBAction func optionsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "Options Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController {
            controller.gameModel = self.gameModel
        }
        else if let controller = segue.destination as? OptionsViewController {
            controller.gameModel = self.gameModel
        }
    }
}

extension MainController: GameModelDelegate {
    
}
