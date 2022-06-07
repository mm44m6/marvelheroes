//
//  FetchCharacters.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation
import RxSwift

protocol FetchCharactersUseCaseProtocol {
    func execute(limit: Int,
                 offset: Int,
                 completion: @escaping (Result<[Character], NetworkError>) -> Void)
}

class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let charactersQueriesRepository: CharactersQueriesRepositoryProtocol

    init(charactersQueriesRepository: CharactersQueriesRepositoryProtocol = CharactersQueriesRepository()) {
        self.charactersQueriesRepository = charactersQueriesRepository
    }

    func execute(limit: Int,
                 offset: Int,
                 completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        charactersQueriesRepository.fetchCharactersList(limit: limit, offset: offset) { result in
            completion(result)
        }
    }
}
