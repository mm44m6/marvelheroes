//
//  Result.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 02/06/22.
//

import Foundation

struct ApiResponse: Decodable {
    let status: String?
    let message: String?
    let data: ApiResultContainer?
}
