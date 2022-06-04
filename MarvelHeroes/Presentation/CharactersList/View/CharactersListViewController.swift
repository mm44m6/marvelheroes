//
//  CharacterDetailsViewController.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 30/05/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol CharactersListViewControllerDelegate: AnyObject {
    func navigateToCharacterDetails(with character: Character)
}

class CharactersListViewController: UIViewController {
    public var delegate: CharactersListViewControllerDelegate?
    private var viewModel: CharactersListViewModelProtocol!
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersListViewModel()
        viewModel.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel?.title
        setupTableView()
        populateTableView()
        setupSearchBar()
        createSpinnerView()
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
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search character"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
    }
    
    private func populateTableView() {
        let charactersObservable = viewModel.characters.asObservable()
        let observable = charactersToDisplay(searchBar: searchBar, charactersObservable: charactersObservable)
        
        observable.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { [unowned self] (currentRow, character, cell) in
            
            guard let character = character else { return }
            
            cell.textLabel?.text = "\(character.name) \(character.description)"
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            
            self.viewModel.handleInfiniteScroll(currentRow: currentRow)
        }.disposed(by: disposeBag)
        
        navigateToDetailsOnClickConfig()
    }
    
    private func navigateToDetailsOnClickConfig() {
        tableView.rx.modelSelected(Character.self).subscribe(onNext:  { [unowned self] character in
            self.delegate?.navigateToCharacterDetails(with: character)
        }).disposed(by: disposeBag)
    }
    
    private func charactersToDisplay(searchBar: UISearchBar,
                                     charactersObservable: Observable<[Character]>
    ) -> Observable<[Character?]> {
        return Observable.combineLatest(
            searchBar
                .rx.text
                .orEmpty
                .debounce(.milliseconds(50), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .startWith(""), charactersObservable
        ).map { [unowned self] searchQuery, characters in
            self.viewModel.filterSearchQuery(query: searchQuery, characters: characters)
        }
    }
    
    func createSpinnerView() {
        let spinnerViewController = SpinnerViewController()
        
        viewModel.isLoading.bind { [unowned self] isLoading in
            if isLoading {
                self.addChild(spinnerViewController)
                spinnerViewController.view.frame = self.view.frame
                self.view.addSubview(spinnerViewController.view)
                spinnerViewController.didMove(toParent: self)
            } else {
                spinnerViewController.willMove(toParent: nil)
                spinnerViewController.view.removeFromSuperview()
                spinnerViewController.removeFromParent()
            }
        }.disposed(by: disposeBag)
    }
}



