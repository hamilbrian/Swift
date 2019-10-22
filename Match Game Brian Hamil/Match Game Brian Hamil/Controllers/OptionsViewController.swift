//
//  Options View Controller.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/1/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    @IBOutlet weak var puzzleSizeLabel: UILabel!
    @IBOutlet weak var set2by2: UIButton!
    @IBOutlet weak var set4dy4: UIButton!
    @IBOutlet weak var set6by6: UIButton!
    
    var gameModel: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        puzzleSizeLabel.text = "Current Puzzle Size: " + String(gameModel.puzzleSize)
    }
    
    @IBAction func set2by2Pressed(_ sender: Any) {
        gameModel.setPuzzleSize(size: 2)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func set4by4Pressed(_ sender: Any) {
        gameModel.setPuzzleSize(size: 4)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func set6by6Pressed(_ sender: Any) {
        gameModel.setPuzzleSize(size: 6)
        self.navigationController?.popViewController(animated: true)
    }
}
