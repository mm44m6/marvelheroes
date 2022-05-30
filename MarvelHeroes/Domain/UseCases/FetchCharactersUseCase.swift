//
//  FetchCharacters.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation

class FetchCharactersUseCase: UseCase {
    private let charactersQueriesRepository: CharactersQueries
    
    init(charactersQueriesRepository: CharactersQueries) {
        self.charactersQueriesRepository = charactersQueriesRepository
    }
}
