//
//  CharacterListViewModel.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchError: Error {
    case notFound
}

protocol CharactersListViewModelProtocol {
    func filterSearchQuery(query: String, characters: [Character]) -> [Character?]
    func handleInfiniteScroll(currentRow: Int)
    func viewDidLoad() -> Void
    var title: String { get }
    var searchError: BehaviorRelay<SearchError?> { get }
    var characters: BehaviorRelay<[Character]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var offset: Int
    
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    let characters: BehaviorRelay<[Character]> = BehaviorRelay(value: [])
    let searchError: BehaviorRelay<SearchError?> = BehaviorRelay(value: nil)
    let title: String
    
    init(title: String = "Marvel Heroes",
         fetchCharactersUseCase: FetchCharactersUseCaseProtocol = FetchCharactersUseCase(),
         offset: Int = 0) {
        self.title = title
        self.fetchCharactersUseCase = fetchCharactersUseCase
        self.offset = offset
    }
    
    public func viewDidLoad() {
        loadCharacterList(limit: 30)
    }
    
    public func filterSearchQuery(query: String, characters: [Character]) -> [Character?] {
        if query.isEmpty { return characters }
        
        let filteredCharacters = characters.filter { $0.name.hasPrefix(query) || $0.name.contains(query) }
        
        if filteredCharacters.isEmpty {
            handleSearchError(error: .notFound)
            return []
        } else {
            return filteredCharacters
        }
    }
    
    public func handleInfiniteScroll(currentRow: Int) {
        let lastElementIndex = characters.value.count - 1
        
        if isLoading.value && currentRow == lastElementIndex {
            loadCharacterList(limit: 30)
        }
    }
    
    private func loadCharacterList(limit: Int) {
        self.isLoading.accept(true)
        offset += limit
        fetchCharactersUseCase.execute(limit: limit, offset: offset) { [unowned self] result in
            switch result {
            case .success(let characters):
                self.characters.accept(self.characters.value + characters)
                self.isLoading.accept(false)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func handleSearchError(error: SearchError) {
        searchError.accept(.notFound)
    }
}
