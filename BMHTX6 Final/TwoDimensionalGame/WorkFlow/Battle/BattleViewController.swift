import UIKit

class BattleViewController: UIViewController {
   
    // Mark: Properties
    
    
    
    // reference to battle model
    private var battleModel: BattleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        battleModel = BattleModel(delegate: self)
    }
}

extension BattleViewController {
    

}

extension BattleViewController: BattleModelDelegate {
    func updateUI() {
        
    }
    
    func attack() {
        
    }
}
