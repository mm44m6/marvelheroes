//
//  CharactersQueriesRepository.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//
import Foundation

typealias CompletionHandler = (AnyObject?) -> Void
typealias CharacterResult = MarvelDataResponse<CharactersResultContainer>

class CharactersQueriesRepository: CharactersQueries {
    let networkApiClient: NetworkApiClientProtocol

    init(networkApiClient: NetworkApiClientProtocol = NetworkApiClient<CharacterResult>()) {
        self.networkApiClient = networkApiClient
    }

    func fetchCharactersList(limit: Int,
                             offset: Int,
                             completion: @escaping (Result<[Character], Error>) -> Void) {
        networkApiClient.callApi(requestType: .get,
                                 queryParameters: ["limit": limit, "offset": offset]) { apiResponse in
            if apiResponse.success {
                guard let characterList = apiResponse.data as? CharacterResult else {
                    return
                }

                completion(.success(characterList.data.results))
            } else {
                guard let error = apiResponse.error else {
                    completion(.failure(NetworkError.unkownNetworkError))
                    return
                }

                completion(.failure(error))
            }
        }
    }
}
