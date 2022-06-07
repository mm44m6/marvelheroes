//
//  CharacterListViewModel.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - Error handling enums
enum SearchError: Error {
    case notFound
}

// MARK: - Class protocol
protocol CharactersListViewModelProtocol {
    func filterSearchQuery(query: String, characters: [Character]) -> [Character?]
    func handleInfiniteScroll(currentRow: Int)
    func viewDidLoad()
    var title: String { get }
    var searchError: BehaviorRelay<SearchError?> { get }
    var characters: BehaviorRelay<[Character]> { get }
    var isFullScreenLoading: BehaviorRelay<Bool> { get }
    var isFooterLoading: BehaviorRelay<Bool> { get }
}

// MARK: - Class implementation
class CharactersListViewModel: CharactersListViewModelProtocol {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var offset: Int

    let isFullScreenLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isFooterLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let characters: BehaviorRelay<[Character]> = BehaviorRelay(value: [])
    let searchError: BehaviorRelay<SearchError?> = BehaviorRelay(value: nil)
    let title: String

    // MARK: - Init
    init(title: String = "Marvel Heroes",
         fetchCharactersUseCase: FetchCharactersUseCaseProtocol = FetchCharactersUseCase(),
         offset: Int = 0) {
        self.title = title
        self.fetchCharactersUseCase = fetchCharactersUseCase
        self.offset = offset
    }

    // MARK: Methods binded to view controller
    public func viewDidLoad() {
        isFullScreenLoading.accept(true)
        loadCharacterList(limit: 30)
    }

    public func filterSearchQuery(query: String, characters: [Character]) -> [Character?] {
        if query.isEmpty { return characters }

        let filteredCharacters = characters.filter {
            $0.name.hasPrefix(query) || $0.name.contains(query)
        }

        if filteredCharacters.isEmpty {
            handleSearchError(error: .notFound)
            return []
        } else {
            return filteredCharacters
        }
    }

    public func handleInfiniteScroll(currentRow: Int) {
        let lastElementIndex = characters.value.count - 1

        var isAnyLoadingVisible: Bool {
            return isFooterLoading.value || isFullScreenLoading.value
        }

        if !isAnyLoadingVisible && currentRow == lastElementIndex {
            loadCharacterList(limit: 30)
            isFooterLoading.accept(true)
        }
    }

    private func loadCharacterList(limit: Int) {
        offset += limit
        fetchCharactersUseCase.execute(limit: limit, offset: offset) { [unowned self] result in
            switch result {
            case .success(let characters):
                self.characters.accept(self.characters.value + characters)
                self.isFooterLoading.accept(false)
                self.isFullScreenLoading.accept(false)
            case .failure(let error):
                print("\(error)")
            }
        }
    }

    private func handleSearchError(error: SearchError) {
        searchError.accept(.notFound)
    }
}
