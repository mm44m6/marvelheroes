//
//  ApiRequest.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 05/06/22.
//

import Alamofire
import Foundation

protocol NetworkApiClientProtocol {
    func callApi(requestType: HTTPMethod, queryParameters: [String: Any]?, completion: @escaping (ApiResponse) -> Void)
}

class NetworkApiClient<ResponseType: Codable>: NetworkApiClientProtocol {
    typealias ResponseHandler = (ApiResponse) -> Void

    private let sessionManager: Alamofire.Session
    private let timestamp: Int64

    init(sessionManager: Alamofire.Session = Alamofire.Session(),
         timestamp: Int64 = Date.currentTimeStamp) {
        self.sessionManager = sessionManager
        self.timestamp = timestamp
    }

    func callApi(requestType: HTTPMethod, queryParameters: [String: Any]? = nil, completion: @escaping ResponseHandler) {
        guard let urlRequest = urlRequestWith(requestType: requestType, queryParameters: queryParameters)
        else {
            let error = self.handleError(error: .unableToCreateUrl)
            completion(error)
            return
        }

        sessionManager.request(urlRequest).responseData { data in
            switch data.result {
            case .success:
                guard let statusCode = data.response?.statusCode else {
                    let error = self.handleError(error: .unkownNetworkError)
                    completion(error)
                    return
                }

                if statusCode == 200 {
                    let apiResponse = self.handleSuccess(data: data.data)
                    completion(apiResponse)
                }

                if statusCode == 409 {
                    let error = self.handleError(error: .missingUrlParameters)
                    completion(error)
                }

                if statusCode > 400 && statusCode != 409 {
                    let error = self.handleError(error: .unableToFetchData)
                    completion(error)
                }
            case .failure:
                let error = self.handleError(error: .unableToFetchData)
                completion(error)
            }
        }
    }

    private func urlRequestWith(requestType: HTTPMethod, queryParameters: [String: Any]?) -> URLRequest? {
        let authenticationKeys = retrieveAuthenticationKeys()

        guard let publicKey = authenticationKeys["publicKey"],
              let privateKey = authenticationKeys["privateKey"]
        else { return nil }

        let api = Api(
            base: "https://gateway.marvel.com/",
            version: "v1/",
            resource: "public/",
            endpoint: "characters",
            publicKey: publicKey,
            privateKey: privateKey,
            queryParameters: queryParameters,
            timestamp: timestamp
        ).url()

        guard let completeUrl = api else { return nil }

        var urlRequest = URLRequest(url: completeUrl)
        urlRequest.httpMethod = requestType.rawValue

        return urlRequest
    }

    private func handleSuccess(data: Data?) -> ApiResponse {
        do {
            guard let data = data else { return ApiResponse(success: false, error: .unableToDecodeData) }

            let decodedValue = try JSONDecoder().decode(ResponseType.self, from: data)

            return ApiResponse(success: true, data: decodedValue as AnyObject)
        } catch {
            return handleError(error: .unableToDecodeData)
        }
    }

    private func handleError(error: NetworkError) -> ApiResponse {
        return ApiResponse(success: false, error: error)
    }

    private func retrieveAuthenticationKeys() -> [String: String] {
        let publicKey = "da3e69b0df701145c835dfce4d351007"
        let privateKey = "dc603d1dd158c1d5d7781b31e11c243946a5312f"

        return ["publicKey": publicKey, "privateKey": privateKey]
    }
}
