import UIKit

protocol EditDeckDelegate: class {
    func deckEditsCompleted(for deck: Deck)
}

class EditDeckViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: EditDeckDelegate?
    var model: EditDeckModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = model?.deck.title
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: nil, using: appWillTerminate(_:))
    }
    
    @objc func appWillTerminate(_ notification: Notification) {
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        model.saveDeck()
        delegate?.deckEditsCompleted(for: model.deck)
    }
    
    @IBAction func addNewCardPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Card", message: "Please insert a front and back for your new card", preferredStyle: .alert)
        alert.addTextField { (titleField) in
            titleField.placeholder = "Back"
        }
        alert.addTextField { (titleField) in
            titleField.placeholder = "Front"
        }
        
        let okayAction = UIAlertAction(
            title: "Okay",
            style: .default,
            handler: { [weak self] (action) in
                if let backTextField = alert.textFields?.first,
                    let frontTextField = alert.textFields?.last,
                    let backText = backTextField.text, !backText.isEmpty,
                    let frontText = frontTextField.text, !frontText.isEmpty {
                    self?.model.addNewCard(withFront: frontText, andBack: backText)
                    self?.tableView.reloadData()
                }
        })
        alert.addAction(okayAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            
        }))
        
        present(alert, animated: true)
    }
}

extension EditDeckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let card = model.cards[indexPath.row]
        cell.textLabel?.text = card.front
        cell.detailTextLabel?.text = card.back
        return cell
    }
}

extension EditDeckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editCard = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
        }
        
        let deleteCard = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.model.removeCard(at: indexPath.row)
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: nil)
        }
        
        return [deleteCard, editCard]
    }
}
