//
//  CharactersQueriesRepository.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation
import CryptoSwift

class CharactersQueriesRepository: CharactersQueries {
    public func fetchCharactersList(limit: Int,
                                    offset: Int,
                                    completion: @escaping (Result<[Character], Error>) -> Void) {
        
        let timestamp = Date.currentTimeStamp
        let publicKey = "da3e69b0df701145c835dfce4d351007"
        let privateKey = "dc603d1dd158c1d5d7781b31e11c243946a5312f"
        let md5 = "\(timestamp)\(privateKey)\(publicKey)".md5()
        
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=da3e69b0df701145c835dfce4d351007&hash=\(md5)&limit=\(limit)&offset=\(offset)") else { return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil, let data = data else {
                    print("No data received:", error ?? URLError(.badServerResponse))
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    
                    if let apiResultContainer = apiResponse.data {
                        completion(.success(apiResultContainer.results))
                    } else if let message = apiResponse.message {
                        completion(.failure(message as! Error))
                    }
                } catch let parseError {
                    print("Parsing error:", parseError, String(describing: String(data: data, encoding: .utf8)))
                }
            }
        }
        
        dataTask.resume()
    }
}
