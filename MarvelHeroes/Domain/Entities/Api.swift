//
//  Endpoints.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//
import CryptoKit
import Foundation

struct Api {
    let base, version, resource, endpoint, publicKey, privateKey: String
    let queryParameters: [String: Any]?
    let timestamp: Int64

    func url() -> URL? {
        var url = base + version + resource + endpoint + "?"

        let sortedQueryAndAuthenticationParameters = mergeQueryAndAuthenticationParameters().sorted { $0.key > $1.key }

        for (index, dict) in sortedQueryAndAuthenticationParameters.enumerated() {
            if index == 0 {
                url += "\(dict.key)=\(dict.value)"
            }

            if index > 0 {
                url += "&\(dict.key)=\(dict.value)"
            }
        }

        guard let url = URL(string: url) else { return nil }

        return url
    }

    private func mergeQueryAndAuthenticationParameters() -> [String: Any] {
        var queryAndAuthenticationParameters: [String: Any] = ["publicKey": "publicKey"]

        if let queryParameters = queryParameters {
            queryAndAuthenticationParameters = queryParameters
        }

        let hash = generateMd5HashString(timestamp: timestamp,
                                         publicKey: publicKey,
                                         privateKey: privateKey)

        queryAndAuthenticationParameters["apikey"] = publicKey
        queryAndAuthenticationParameters["ts"] = timestamp
        queryAndAuthenticationParameters["hash"] = hash

        return queryAndAuthenticationParameters
    }

    func generateMd5HashString(timestamp: Int64,
                               publicKey: String,
                               privateKey: String
    ) -> String? {
        guard let stringToData = "\(timestamp)\(privateKey)\(publicKey)".data(using: .utf8) else { return nil }

        return Insecure.MD5.hash(data: stringToData).map { String(format: "%02hhx", $0) }.joined()
    }
}
