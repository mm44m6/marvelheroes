//
//  CharacterDetailsViewController.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 30/05/22.
//

import Foundation
import UIKit
import RxSwift

protocol CharactersListViewControllerDelegate: AnyObject {
    func navigateToCharacterDetails(with character: Character)
}

class CharactersListViewController: UIViewController {
    public var delegate: CharactersListViewControllerDelegate?
    private var viewModel: CharactersListViewModelProtocol?
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersListViewModel()
        viewModel?.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel?.title
        setupTableView()
        populateTable()
    }
    
    private func setupTableView() {
        tableView.frame = self.view.frame
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func populateTable() {
        viewModel?.characters.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, model, cell) in
            cell.textLabel?.text = "\(model.name) \(model.description)"
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)
        
        teste()
    }
    
    private func teste() {
        tableView.rx.modelSelected(Character.self).subscribe(onNext:  { [weak self] value in
            self?.delegate?.navigateToCharacterDetails(with: value)
        }).disposed(by: disposeBag)
    }
}

