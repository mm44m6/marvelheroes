//
//  EndpointTests.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 05/06/22.
//

import XCTest

@testable import MarvelHeroes

class EndpointTests: XCTestCase {
    // MARK: -fullRequestUrl() tests
    
    func testWhenAllParametersAreProvidedShouldReturnFullRequestUrl() {
        // Given
        let sut = Api(
            base: "http://test.com/",
            version: "v1",
            resource: "/public",
            endpoint: "/characters",
            queryParameters: ["limit": 10],
            publicKey: "testPublicKey123",
            privateKey: "testPrivateKey123",
            timestamp: 1234
        )
        
        let expectedEnpointUrl = URL(string: "http://test.com/v1/public/characters?ts=1234&limit=10&hash=fef931b21ce5d87ed2f7a290380104bb&apikey=testPublicKey123")
        
        // When
        let resultedEndpointUrl = sut.url()

        // Then
        XCTAssertEqual(expectedEnpointUrl, resultedEndpointUrl)
    }
    
    func testWhenQueryParametersAreNotProvidedShouldReturnFullRequestUrl() {
        // Given
        let sut = Api(
            base: "http://test.com/",
            version: "v1",
            resource: "/public",
            endpoint: "/characters",
            queryParameters: nil,
            publicKey: "testPublicKey123",
            privateKey: "testPrivateKey123",
            timestamp: 1234
        )
        
        let expectedEnpointUrl = URL(string: "http://test.com/v1/public/characters?ts=1234&publicKey=publicKey&hash=fef931b21ce5d87ed2f7a290380104bb&apikey=testPublicKey123")
        
        // When
        let resultedEndpointUrl = sut.url()

        // Then
        XCTAssertEqual(expectedEnpointUrl, resultedEndpointUrl)
    }
}
