import Foundation

protocol BattleModelDelegate: class {
    func updateUI()
    func attack()
    func flee(playerWeapon: String, playerHealth: Int)
    func victory(playerHealth: Int)
    func death()
}

final class BattleModel {
    
    // delegate decleration
    private weak var delegate: BattleModelDelegate?
    
    // enemy stats
    var enemyHealth = 100
    var enemyName: String
    var eventText = ""
    var playerHealth: Int
    var playerWeapon: String

    // get data from the game model
    init (delegate: BattleModelDelegate, playerHealth: Int, enemyName: String, playerWeapon: String) {
        self.delegate = delegate
        self.playerHealth = playerHealth
        self.enemyName = enemyName
        self.playerWeapon = playerWeapon
    }
}

extension BattleModel {
    
    func updateSelf() {
        // don't need to change anything here
    }
    
    func handleAttack() {
        
        if playerWeapon != "" {
            let weaponDamage = Int.random(in: 1 ... 10)
            let chanceToBreakWeapon = Int.random(in: 0 ... 100)
            let chanceToGetHurt = Int.random(in: 0 ... 100)
            let enemyDamage = Int.random(in: 1 ... 10)
            
            if chanceToGetHurt > 75 {
                playerHealth = playerHealth - enemyDamage
                eventText = "The " + enemyName + " damaged you for " + String(enemyDamage) + " health!"
            }
                
            else if chanceToBreakWeapon > 75 {
                
                eventText = "You broke your weapon! Run!"
                playerWeapon = ""
            }
            else {
                enemyHealth = enemyHealth - weaponDamage
                
                eventText = "You damaged the " + enemyName + " for " + String(weaponDamage) + " damage!"
            }
        }
            
        else {
            eventText = "Your weapon is broken, run!"
        }

    }
    
    func handleFlee() {
        delegate?.flee(playerWeapon: playerWeapon, playerHealth: playerHealth)
    }
    
    func handleDeath() {
        delegate?.death()
    }
    
    func handleVictory () {
        delegate?.victory(playerHealth: playerHealth)
    }
    
    func handleDrinkPotion() {
        let addingHealth = Int.random(in: 1 ... 3)
        if (playerHealth + addingHealth) < 100 {
            playerHealth += addingHealth
        }
        else {
            eventText = "You can't drink anymore."
        }
        
        let chanceToGetHurt = Int.random(in: 0 ... 100)
        let enemyDamage = Int.random(in: 1 ... 10)
        
        if chanceToGetHurt > 75 {
            playerHealth = playerHealth - enemyDamage
            eventText = "The " + enemyName + " damaged you for " + String(enemyDamage) + " health!"
        }
        
    }
}
