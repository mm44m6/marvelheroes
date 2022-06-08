//
//  CharacterDetailsViewController.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 30/05/22.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol CharactersListViewControllerDelegate: AnyObject {
    func navigateToCharacterDetails(with character: Character)
}

class CharactersListViewController: UIViewController {
    public var delegate: CharactersListViewControllerDelegate?
    private var viewModel: CharactersListViewModelProtocol!
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    init(viewModel: CharactersListViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        title = viewModel?.title
        setupTableView()
        populateTableView()
        setupSearchBarView()
        createFullScreenSpinnerView()
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.register(CharacterListCellViewController.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.frame = view.frame
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupSearchBarView() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = String(localized: "search_characters_placeholder")
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
    }

    private func populateTableView() {
        let charactersObservable = viewModel.characters.asObservable()
        let observable = charactersToDisplay(searchBar: searchBar, charactersObservable: charactersObservable)

        observable.bind(to: tableView.rx.items) { [unowned self] currentTableView, currentRow, character in
            guard let character = character else { return UITableViewCell() }

            let cell = currentTableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: currentRow, section: 0)) as! CharacterListCellViewController

            cell.tag = currentRow
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
            cell.contentView.layer.borderWidth = 1.0

            cell.characterNameLabel.text = character.name
            cell.characterDescriptionLabel.text = character.getDescription
            cell.characterThumbnail = character.thumbnail
            cell.setupCharacterThumbnailView()

            currentTableView.rowHeight = tableView.frame.height / 4

            self.viewModel.handleInfiniteScroll(currentRow: currentRow)
            createFooterSpinnerView()
            return cell
        }.disposed(by: disposeBag)

        navigateToDetailsOnClickConfig()
    }

    private func navigateToDetailsOnClickConfig() {
        tableView.rx.modelSelected(Character.self).subscribe(onNext: { [unowned self] character in
                self.delegate?.navigateToCharacterDetails(with: character)
            }
        ).disposed(by: disposeBag)
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

    func createFullScreenSpinnerView() {
        let spinnerViewController = SpinnerViewController()

        viewModel.isFullScreenLoading.bind { [unowned self] isLoadingFullScreen in
            if isLoadingFullScreen {
                self.addChild(spinnerViewController)
                self.view.addSubview(spinnerViewController.view)
                spinnerViewController.view.frame = self.view.frame
                spinnerViewController.didMove(toParent: self)
            } else {
                spinnerViewController.willMove(toParent: nil)
                spinnerViewController.view.removeFromSuperview()
                spinnerViewController.removeFromParent()
            }
        }.disposed(by: disposeBag)
    }

    func createFooterSpinnerView() {
        viewModel.isFooterLoading.bind { [unowned self] isLoadingFooter in
            if isLoadingFooter {
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(44))

                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
            } else {
                self.tableView.tableFooterView?.isHidden = true
            }
        }.disposed(by: disposeBag)
    }
}
