//
//  CharactersQueriesRepository.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation

protocol CharactersQueries {
    func fetchCharactersList(limit: Int, completion: @escaping (Result<[Character], Error>) -> Void)
}
