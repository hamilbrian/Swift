import UIKit

class BattleViewController: UIViewController {
   
    @IBOutlet private weak var eventText: UILabel!
    @IBOutlet private weak var enemyName: UILabel!
    @IBOutlet private weak var enemyImage: UIImageView!
    @IBOutlet private weak var enemyHealth: UILabel!
    @IBOutlet private weak var playerWeapon: UILabel!
    @IBOutlet private weak var playerHealth: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // reference to battle model
    private var battleModel: BattleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateUI()
    }
}

extension BattleViewController {

    func setup(battleModel: BattleModel) {
        self.battleModel = battleModel
    }
}

extension BattleViewController: BattleModelDelegate {
    func victory(playerHealth: Int) {
        // don't need to change anything here
    }
    
    func victory() {
        // don't need to change anything here
    }
    
    func death() {
        // don't need to change anything here
    }
    
    func flee(playerWeapon: String, playerHealth: Int) {
        // don't need to change anything here
    }
    
    func updateUI() {
        battleModel.updateSelf()
        
        enemyImage.image = UIImage(named: battleModel.enemyName)
        
        // set all the label text
        enemyName.text = battleModel.enemyName
        enemyHealth.text = "Enemy Health: " + String(battleModel.enemyHealth)
        playerWeapon.text = "Weapon: " + battleModel.playerWeapon
        playerHealth.text = "Player Health: " + String(battleModel.playerHealth)
        eventText.text = battleModel.eventText
        
        if battleModel.enemyHealth <= 0 {
            battleModel.handleVictory()
            navigationController?.popViewController(animated: true)
        }
        
        if battleModel.playerHealth <= 0 {
            battleModel.handleDeath()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func attack() {
        
        battleModel.handleAttack()
        updateUI()
    }
    
    func flee() {
        
        battleModel.handleFlee()
        // get rid of the battle view screen
        navigationController?.popViewController(animated: true)
    }
    
    func drinkpotion() {
        battleModel.handleDrinkPotion()
        updateUI()
    }
}

enum Actions: String, CaseIterable {
    case attack = "Attack" // raw value should be display value
    case flee = "Flee"
    case drinkpotion = "Drink Health Potion"
}

// these two extensions are what add the rows to the table view
extension BattleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Actions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let action = Actions.allCases[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell")!
        
        cell.textLabel?.text = action.rawValue

        return cell
    }
}

extension BattleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let action = Actions.allCases[indexPath.row]
        
        switch action {
            
        case .attack:
            attack()
        case .flee:
            flee()
        case .drinkpotion:
            drinkpotion()
        }
    }
}
