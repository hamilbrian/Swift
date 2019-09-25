import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addLoginScreen()
    }
    
    func addLoginScreen() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? LoginViewController else { return }
        controller.delegate = self
        controller.willMove(toParent: self)
        addChild(controller)
        self.view.addSubview(controller.view)
        controller.view.pinFullscreen(to: self.view)
        controller.didMove(toParent: self)
    }

    func transitionToViewController() {
        // Need to create from the storyboard and NOT directly
//        let decksController = DecksViewController()
        let storyboard = UIStoryboard(name: "Decks", bundle: nil)
        guard let newController = storyboard.instantiateInitialViewController() else { return }
        
        let current = children.first!
        
        replace(current: current, with: newController, animationDuration: 0.25, setup: { (newController) in
            if let decksController = newController.children.first as? DecksViewController {
                decksController.model = DecksModel()
            }
        }, prepare: { (old, new) in
            new.view.alpha = 0.0
        }, animationTransition: { (old, new) in
            old.view.alpha = 0.0
            new.view.alpha = 1.0
        }) { (completed) in
            
        }
        
        
//        replace(current: current, with: navigationController, animationDuration: 1.0, animationTransition: { (current, next) in
//            current.view.alpha = 0.0
//            next.view.alpha = 1.0
//        }) { (completed) in
//            print("I am done!")
//        }
        
//        navigationController.willMove(toParent: self)
//        let current = children.first!
//        addChild(navigationController)
//        self.view.addSubview(navigationController.view)
//        navigationController.view.pinFullscreen(to: self.view)
//        navigationController.didMove(toParent: self)
//
//        current.willMove(toParent: nil)
//        current.view.removeFromSuperview()
//        current.removeFromParent()
    }
}

extension MasterViewController: LoginViewControllerDelegate {
    func userLoggedIn() {
        transitionToViewController()
    }
}
