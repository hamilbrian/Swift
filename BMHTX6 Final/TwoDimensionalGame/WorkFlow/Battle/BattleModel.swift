
import Foundation

protocol BattleModelDelegate: class {
    func updateUI()
    func attack()
}

final class BattleModel {
    
    // delegate decleration
    private weak var delegate: BattleModelDelegate?
    
// enemy stats
var enemyHealth = 100
var enemyName = "Goblin"
    
    init (delegate: BattleModelDelegate) {
        self.delegate = delegate
        
    }


}
