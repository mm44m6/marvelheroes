//
//  DataContainer.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 02/06/22.
//

import Foundation

struct CharactersResultContainer: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}
