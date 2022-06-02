//
//  CharacterListViewModel.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import Foundation
import RxSwift
import RxCocoa


protocol CharacterListViewModelProtocol {
    func viewDidLoad() -> Void
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    
    let title: String
    let characters: BehaviorRelay<[Character]> = BehaviorRelay(value: [])
    
    init(title: String = "Marvel Heroes",
         fetchCharactersUseCase: FetchCharactersUseCaseProtocol = FetchCharactersUseCase()) {
        self.title = title
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
    
    func viewDidLoad() {
        loadCharacterList(limit: 30)
    }
    
    private func loadCharacterList(limit: Int) {
        fetchCharactersUseCase.execute(limit: limit) { result in
            switch result {
            case .success(let characters):
                self.characters.accept(characters)
            case .failure(let error):
                print(error)
            }
        }
    }
}
