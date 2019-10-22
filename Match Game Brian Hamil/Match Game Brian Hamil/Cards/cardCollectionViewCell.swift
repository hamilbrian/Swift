//
//  cardCollectionViewCell.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/3/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import UIKit

class cardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardLabel: UILabel!
    
    var cardNumber = 0
    var flipped = false
    var matched = false
    var card = Card.init(front: "front", back: "back")
    
    override class func awakeFromNib() {
        
    }
    
    func configureCard(number: Int, card: Card ){
        self.cardNumber = number
        self.card = card
        cardLabel.text = card.back
        self.backgroundColor = .blue
    }
    
    func flipCard(_ completion: @escaping () -> Void) {
        let option: UIView.AnimationOptions = flipped ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        if self.matched == false {
            
            UIView.transition(with: self, duration: 0.25, options: option, animations: {
                if self.flipped == false {
                    self.cardLabel.text = self.card.front
                    self.flipped = true
                }
                else {
                    self.cardLabel.text = self.card.back
                    self.flipped = false
                }
            }) { (complete) in completion() }
        }
    }
}
