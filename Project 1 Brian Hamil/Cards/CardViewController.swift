//
//  CardsViewController.swift
//  Project 1 Brian Hamil
//
//  Created by Hamil, Brian (UMSL-Student) on 9/16/19.
//  Copyright © 2019 Hamil, Brian (UMSL-Student). All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var cardLabel: UILabel!
    
    var isShowing = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardContainerView.layoutIfNeeded()
    }
    
    @IBAction func flipCardTapGesturePressed(_ sender: UITapGestureRecognizer) {
        
        let option: UIView.AnimationOptions = isShowing ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(with: cardContainerView, duration: 0.25, options: option, animations: {

        })
    }
    
}
