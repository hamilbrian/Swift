import UIKit

class CardsViewController: UIViewController {
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var model: CardsModel?
    var isShowing = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardContainerView.layoutIfNeeded()
        cardContainerView.drawShadow(withOffset: CGSize(width: 2, height: 2), radius: 3.0, opacity: 0.25)
        title = model?.deck.title
        let card = model?.getRandomCard()
        self.cardLabel.text = card?.back
        makeGameGrid()
    }
    
    @IBAction func flipCardTapGesturePressed(_ sender: UITapGestureRecognizer) {
        tapGesture.isEnabled = isShowing
        animateCardFlip {
            if self.isShowing {
                self.model?.cardFrontWasShown()
                self.flipToNewCard(after: 2.0)
            }
        }
    }
    
    private func animateCardFlip(_ completion: @escaping () -> Void) {
        let option: UIView.AnimationOptions = isShowing ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(with: cardContainerView, duration: 0.25, options: option, animations: {
            if self.isShowing {
                self.cardLabel.text = self.model?.currentCard?.back
            } else {
                self.cardLabel.text = self.model?.currentCard?.front
            }
        }) { (complete) in
            self.isShowing = !self.isShowing
            completion()
        }
    }
    
    private func flipToNewCard(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: { [weak self] in
            self?.animateCardFlip {
                if let strongSelf = self {
                    self?.tapGesture.isEnabled = !strongSelf.isShowing
                }
            }
        })
    }
    
    deinit {
        print("\(#function) at \(#line)")
    }
    
    func makeGameGrid() {
        for index in 1...6 {
            for subIndex in 1...6 {
                let cell = UICollectionViewCell()
                cell.backgroundColor = UIColor.red
                cardCollectionView.addSubview(cell)
                print(index, subIndex)
            }
        }
    }
}
