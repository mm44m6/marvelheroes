//
//  CharactersQueriesRepository.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//
import Foundation

class CharactersQueriesRepository: CharactersQueriesRepositoryProtocol {
    typealias CompletionHandler = (AnyObject?) -> Void
    typealias CharacterResult = MarvelDataResponse<CharactersResultContainer>

    let networkApiClient: NetworkApiClientProtocol

    init(networkApiClient: NetworkApiClientProtocol = NetworkApiClient<CharacterResult>()) {
        self.networkApiClient = networkApiClient
    }

    func fetchCharactersList(limit: Int,
                             offset: Int,
                             completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        networkApiClient.callApi(requestType: .get,
                                 queryParameters: ["limit": limit, "offset": offset]) { apiResponse in
            if apiResponse.success {
                guard let characterList = apiResponse.data as? CharacterResult else {
                    completion(.failure(NetworkError.noDataReturned))
                    return
                }

                completion(.success(characterList.data.results))
            } else {
                if let networkError = apiResponse.error {
                    completion(.failure(networkError))
                    return
                }

                completion(.failure(NetworkError.unkownNetworkError))
            }
        }
    }
}
