//
//  NetworkError+Error.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 05/06/22.
//

import Foundation

enum NetworkError: Error {
    case unableToCreateUrl
    case unableToFetchData
    case unableToDecodeData
    case missingUrlParameters
    case unkownNetworkError
}
