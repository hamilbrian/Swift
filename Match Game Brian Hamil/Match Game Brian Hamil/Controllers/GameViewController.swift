//
//  GameViewController.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/2/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import UIKit

class GameViewController: UICollectionViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50, right: 20.0)
    
    private let reuseIdentifier = "Card Cell"
    
    var gameModel: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "cardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        gameModel.setPuzzleSize(size: gameModel.puzzleSize)
    }
}

extension GameViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameModel.gridSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! cardCollectionViewCell
        cell.configureCard(number: indexPath.row, card: gameModel.cards[indexPath.row])
        
        return cell
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(gameModel.puzzleSize + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(gameModel.puzzleSize)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingforSectionA section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension GameViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! cardCollectionViewCell
        if cell.flipped == false {
            cell.flipCard{}
            let cell2 = collectionView.cellForItem(at: self.gameModel.lastPicked) as? cardCollectionViewCell
            if gameModel.lastPicked.isEmpty == false {
                cell.matched = gameModel.compareCards(card1: gameModel.cards[gameModel.lastPicked.row], card2: gameModel.cards[indexPath.row])
                cell2?.matched = cell.matched
                if cell.matched == false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        cell.flipCard{}
                        cell2?.flipCard{}
                    })
                }
                else {
                    if checkCards() == true {
                        let alert = UIAlertController(title: "You win!", message: "Play again:?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.gameOver() } ))
                        self.present(alert, animated: true)
                    }
                    else {
                        gameModel.lastPicked = IndexPath.init()
                    }
                }
            }
            else {
                gameModel.lastPicked = indexPath
            }
        }
    }
    
    func checkCards() -> Bool {
        var result = false
        for row in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = NSIndexPath(row: row, section: 0)
            let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! cardCollectionViewCell
            if cell.matched == false {
                result = false
                break
            }
            else {
                result = true
            }
        }
        return result
    }
    
    func gameOver() {
        self.navigationController?.popViewController(animated: true)
    }
}
