//
//  CharacterDetailViewController.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import Foundation
import UIKit

protocol CharacterDetailsViewControllerDelegate: AnyObject {
    func navigateToFirstPage()
}

class CharacterDetailsViewController: UIViewController {
    
    var delegate: CharacterDetailsViewControllerDelegate?
    
    @IBAction func testeAgain(_ sender: Any) {
        delegate?.navigateToFirstPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
