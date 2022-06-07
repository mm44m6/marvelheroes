//
//  NetworkApiClientMock.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 07/06/22.
//

import Foundation
import Alamofire

@testable import MarvelHeroes

struct NetworkApiClientMock: NetworkApiClientProtocol {
    typealias ResponseHandler = (ApiResponse) -> Void
    
    var shouldReturnError: Bool = false
    var shouldReturnData: Bool = true
    var networkError: NetworkError? = nil

    func callApi(requestType: HTTPMethod, queryParameters: [String : Any]?, completion: @escaping (ApiResponse) -> Void) {
        if shouldReturnError {
            completion(ApiResponse(success: false, error: networkError))
        } else {
            if shouldReturnData {
                let characters = CharactersMock.createMockedCharactersList()
                let marvelResponse = CharactersMock.createMockedMarvelDataResponse(
                    offset: queryParameters!["offset"] as! Int,
                    limit: queryParameters!["limit"] as! Int,
                    results: characters,
                    code: 200,
                    status: "Ok")
                
                completion(ApiResponse(success: true, data: marvelResponse as AnyObject))
            } else {
                completion(ApiResponse(success: true, data: nil))
            }
        }
    }
}
