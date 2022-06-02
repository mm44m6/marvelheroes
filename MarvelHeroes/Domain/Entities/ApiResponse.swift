//
//  Result.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 02/06/22.
//

import Foundation

public struct ApiResponse: Decodable {
    public let status: String?
    public let message: String?
    public let data: ApiResultContainer?
}
