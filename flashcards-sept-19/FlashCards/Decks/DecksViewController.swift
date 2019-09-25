import UIKit

class DecksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model: DecksModel!
    private var selectedDeck: Deck?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
            let editDeckController = navController.children.first as? EditDeckViewController, let index = sender as? Int {
            let deck = model.decks[index]
            editDeckController.delegate = self
            editDeckController.model = EditDeckModel(deck: deck)
        } else if let cardsViewController = segue.destination as? CardsViewController {
            if let selectedDeck = self.selectedDeck {
                cardsViewController.model = CardsModel(deck: selectedDeck)
            }
        }
    }
    
    @IBAction func addNewDeckPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Deck", message: "What do you want to name your new deck?", preferredStyle: .alert)
        alert.addTextField { (titleField) in
            titleField.placeholder = "Deck Name"
        }
        let okayAction = UIAlertAction(
            title: "Okay",
            style: .default,
            handler: { [weak self] (action) in
                guard let _self = self else { return }
                if let textField = alert.textFields?.first,
                    let text = textField.text, !text.isEmpty {
                    _self.model.createEmptyDeck(with: text)
                    _self.tableView.reloadData()
                }
        })
        alert.addAction(okayAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            
        }))
        
        present(alert, animated: true)
    }
    
    deinit {
        print("\(#function) in \(String(describing: DecksViewController.self))")
    }

}

extension DecksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let deck = model.decks[indexPath.row]
        
        cell.textLabel?.text = deck.title
        cell.detailTextLabel?.text = "Detail \(indexPath.row + 1)"
        
        return cell
    }
    
    
}

extension DecksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDeck = model.decks[indexPath.row]
        performSegue(withIdentifier: "Start Cards", sender: nil)
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editDeck = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "Edit Deck", sender: indexPath.row)
            
        }
        let deleteDeck = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.model.removeDeck(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        return [deleteDeck, editDeck]
    }
}

extension DecksViewController: EditDeckDelegate {
    func deckEditsCompleted(for deck: Deck) {
        model.replaceExistingDeck(with: deck)
        tableView.reloadData()
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
