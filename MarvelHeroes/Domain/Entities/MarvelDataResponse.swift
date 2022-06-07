//
//  MarvelDataResponse.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 05/06/22.
//

import Foundation

struct MarvelDataResponse<ResultContainer: Codable>: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: ResultContainer
}
