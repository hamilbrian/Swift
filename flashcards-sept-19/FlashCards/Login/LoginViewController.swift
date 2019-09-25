import UIKit

protocol LoginViewControllerDelegate: class {
    func userLoggedIn()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        optionsButton.addTarget(self, action:
            #selector(optionsButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        delegate?.userLoggedIn()
    }
    
    @objc func optionsButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Options", message: "Select a puzzle size", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Two by Two", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Four by Four", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Six by Six", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    deinit {
        print("\(#function) in \(String(describing: LoginViewController.self))")
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}
