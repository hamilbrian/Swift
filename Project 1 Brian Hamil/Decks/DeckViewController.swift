//
//  DeckViewController.swift
//  Project 1 Brian Hamil
//
//  Created by Hamil, Brian (UMSL-Student) on 9/16/19.
//  Copyright © 2019 Hamil, Brian (UMSL-Student). All rights reserved.
//

import UIKit

class DeckViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Deck Screen"
        
        view.addSubview(label)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1.0).isActive = true
        
        label.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1.0).isActive = true
        
    }
}
