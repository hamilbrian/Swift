import UIKit

class GameViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet private weak var NormalEvent: UILabel!
    @IBOutlet private weak var Position: UILabel!
    
    // direction and reset buttons
    @IBOutlet private weak var NorthButton: UIButton!
    @IBOutlet private weak var WestButton: UIButton!
    @IBOutlet private weak var EastButton: UIButton!
    @IBOutlet private weak var SouthButton: UIButton!
    @IBOutlet private weak var ResetButton: UIButton!
    
    // inventory labels
    @IBOutlet private weak var GoldLabel: UILabel!
    @IBOutlet private weak var WeaponLabel: UILabel!
    @IBOutlet private weak var HealthLabel: UILabel!
    
    // the simple "animation" view for the world
    @IBOutlet private weak var gameGridView: UIView!
    @IBOutlet private weak var playerIcon: UIView!
    
    // constraints for player icon
    @IBOutlet private weak var playerViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet private weak var playerViewCenterXConstraint: NSLayoutConstraint!
    
    private var gameModel: GameModel!
    
    // initial loading
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModel = GameModel(delegate: self)
        
        // update view from saved info
        setStartingLocation()
        updateUIView()
    }
}
    
extension GameViewController {
  
    @IBAction func NorthPressed(_ sender: Any) {
        gameModel.move(direction: .north)
        animateMovement(direction: .north)
        updateUIView()
        gameModel.saveGame()
    }
    
    @IBAction func EastPressed(_ sender: Any) {
        gameModel.move(direction: .east)
        animateMovement(direction: .east)
        updateUIView()
        gameModel.saveGame()
    }
    
    @IBAction func WestPressed(_ sender: Any) {
        gameModel.move(direction: .west)
        animateMovement(direction: .west)
        updateUIView()
        gameModel.saveGame()
    }
    
    @IBAction func SouthPressed(_ sender: Any) {
        gameModel.move(direction: .south)
        animateMovement(direction: .south)
        updateUIView()
        gameModel.saveGame()
    }
    
    @IBAction func ResetPressed(_ sender: Any) {
        playerViewCenterXConstraint.constant = 0.0
        playerViewCenterYConstraint.constant = 0.0
        gameModel.fastTravelHome()
        updateUIView()
        gameModel.saveGame()
    }
}

extension GameViewController: GameModelDelegate {
    
    func updateUIView() {
        
        // check for world limit
        limitAlert()
        
        if gameModel.specialEvent.isEmpty { /* do nothing */ }
            
        else {
            let alert = UIAlertController(title: "You found:", message: gameModel.specialEvent, preferredStyle: .alert)
            
            if (gameModel.enemy.isEmpty == true && gameModel.foundWeapon.isEmpty == true) {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            }
            
            if (gameModel.foundWeapon.isEmpty == false) {
                alert.addAction(UIAlertAction(title: "Leave it", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Equip", style: .default, handler: { [weak self] (alert: UIAlertAction!) in self?.gameModel.equipWeapon(); self?.updateUIView()}))
            }
            
            if (gameModel.enemy.isEmpty == false) {
                if (gameModel.equippedWeapon != "none") {
                    alert.addAction(UIAlertAction(title: "Attack " + gameModel.enemy, style: .default, handler: { [weak self] (alert: UIAlertAction!) in self?.gameModel.attack(); self?.updateUIView()}))
                }
                alert.addAction(UIAlertAction(title: "Run", style: .default, handler: nil))
            }
            
            alert.view.backgroundColor = UIColor(red: CGFloat(gameModel.red), green: CGFloat(gameModel.green), blue: CGFloat(gameModel.blue), alpha: 1)
            self.present(alert, animated: true)
        }
        
        if gameModel.gold >= 5 {
            ResetButton.isEnabled = true
        }
        else {
            ResetButton.isEnabled = false
        }
        
        Position.text = gameModel.currentPosition
        NormalEvent.text = gameModel.normalEvent
        NorthButton.isEnabled = gameModel.directions[0]
        SouthButton.isEnabled = gameModel.directions[1]
        EastButton.isEnabled = gameModel.directions[2]
        WestButton.isEnabled = gameModel.directions[3]
        GoldLabel.text = "Gold: " + String(gameModel.gold)
        WeaponLabel.text = "Weapon: " + gameModel.equippedWeapon
        HealthLabel.text = "Health: " + String(gameModel.playerHealth)
    }
    
    func limitAlert() {
        
        if (gameModel.limitAlerts[0] == true) {
            let alert = UIAlertController(title: "You've reached an edge of the world", message: "You cannot go further north", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        if (gameModel.limitAlerts[1] == true) {
            let alert = UIAlertController(title: "You've reached an edge of the world", message: "You cannot go further south", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        if (gameModel.limitAlerts[2] == true) {
            let alert = UIAlertController(title: "You've reached an edge of the world", message: "You cannot go further east", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        if (gameModel.limitAlerts[3] == true) {
            let alert = UIAlertController(title: "You've reached an edge of the world", message: "You cannot go further west", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func animateMovement (direction: Direction) {
        let movementLength = gameGridView.frame.height / gameModel.rowCount
        
        switch direction {
            case .north: playerViewCenterYConstraint.constant -= movementLength
            case .east: playerViewCenterXConstraint.constant -= movementLength
            case .west: playerViewCenterXConstraint.constant += movementLength
            case .south: playerViewCenterYConstraint.constant += movementLength
        }
        
        // UIViewPropertyAnimator is a UIKit object that controls the animation of UIView properties.
        let animator = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.75) { [weak self] in
            // Animate the laying out of our ViewController's root view subviews
            // over the specified duration
            self?.view.layoutIfNeeded()
        }
        
        // Ensure buttons can't be tapped during animation
        animator.isUserInteractionEnabled = false
        // Begin animating
        animator.startAnimation()
    }
    
    func setStartingLocation() {

    }
}

