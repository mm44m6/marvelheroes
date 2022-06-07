//
//  CharactersQueriesRepository.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation

protocol CharactersQueriesRepositoryProtocol {
    func fetchCharactersList(limit: Int,
                             offset: Int,
                             completion: @escaping (Result<[Character], NetworkError>) -> Void)
}
