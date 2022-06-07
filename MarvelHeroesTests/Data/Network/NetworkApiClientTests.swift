//
//  NetworkApiClientTests.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 06/06/22.
//

import Foundation
import XCTest
import Mocker
import Alamofire

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@testable import MarvelHeroes

class NetworkApiClientTests: XCTestCase {
    // MARK: Tests configs
    private var sut: NetworkApiClientProtocol?
    private var timestamp: Int64?
    private var mockedData: Data?
    
    override func setUp() {
        timestamp = Date.currentTimeStamp
        sut = NetworkApiClient<MarvelDataResponse<CharactersResultContainer>>(
            sessionManager: configureAlamofireMockedSession(),
            timestamp: timestamp!
        )
        mockedData = MockerData.charactersList.data
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        timestamp = nil
        super.tearDown()
    }
    
    //MARK: - func callApi tests
    func testWhenApiIsCalledAndUrlHasRightParametersShouldReturnData() {
        // GIVEN
        let expectation = self.expectation(description: "Data request should succeed")

        let originalURL = generateOriginalUrl(timestamp: timestamp!)

        Mock(url: originalURL!, dataType: .json, statusCode: 200, data: [.get: mockedData!]).register()

        // WHEN
        sut?.callApi(requestType: .get, queryParameters: ["limit": 10, "offset": 10]) { response in
            // THEN
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiIsCalledAndUrlDoesNotHaveRightParametersShouldReturnError() {
        // GIVEN
        let expectation = self.expectation(description: "Data request should succeed")

        let originalURL = generateOriginalUrl(timestamp: timestamp!)

        Mock(url: originalURL!, dataType: .json, statusCode: 409, data: [.get: mockedData!]).register()

        // WHEN
        sut?.callApi(requestType: .get, queryParameters: ["limit": 10, "offset": 10]) { response in
            // THEN
            XCTAssertNotNil(response.error)
            XCTAssertEqual(response.error, NetworkError.missingUrlParameters)
            XCTAssertNil(response.data)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiIsCalledAndJsonCantBeParsedShouldReturnError() {
        // GIVEN
        let expectation = self.expectation(description: "Data request should succeed")

        let sessionManager = configureAlamofireMockedSession()

        let originalURL = generateOriginalUrl(timestamp: timestamp!)

        sut = NetworkApiClient<Character>(sessionManager: sessionManager, timestamp: timestamp!)

        Mock(url: originalURL!, dataType: .json, statusCode: 200, data: [.get: mockedData!]).register()

        // WHEN
        sut?.callApi(requestType: .get, queryParameters: ["limit": 10, "offset": 10]) { response in
            // THEN
            XCTAssertNotNil(response.error)
            XCTAssertEqual(response.error, NetworkError.unableToDecodeData)
            XCTAssertNil(response.data)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiIsCalledAndStatusCodeIsNot200ShouldReturnError() {
        // GIVEN
        let expectation = self.expectation(description: "Data request should fail")

        let originalURL = generateOriginalUrl(timestamp: timestamp!)

        Mock(url: originalURL!, dataType: .json, statusCode: 500, data: [.get: mockedData!]).register()

        // WHEN
        sut?.callApi(requestType: .get, queryParameters: ["limit": 10, "offset": 10]) { response in
            // THEN
            XCTAssertNotNil(response.error)
            XCTAssertEqual(response.error, NetworkError.unableToFetchData)
            XCTAssertNil(response.data)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiIsCalledAndApiParametersAreValidShouldReturnValidUrl() {
        // GIVEN
        let expectation = self.expectation(description: "Data request should succeed")

        let originalURL = generateOriginalUrl(timestamp: timestamp!)

        let expectedUrlQueries = generateUrlQueries(using: originalURL!, timestamp: timestamp!)

        var mock = Mock(url: originalURL!, dataType: .json, statusCode: 200, data: [.get: mockedData!])

        // WHEN
        sut?.callApi(requestType: .get, queryParameters: ["limit": 10, "offset": 10]) { _ in }
        
        mock.onRequest = { request, _ in
            let urlWithoutQuery = request.url?.absoluteString.replacingOccurrences(of: request.url!.query!, with: "")
            
            // THEN
            XCTAssertEqual(urlWithoutQuery, "https://gateway.marvel.com/v1/public/characters?")
            XCTAssertEqual(request.url?.query, expectedUrlQueries)

            expectation.fulfill()
        }
        
        mock.register()

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiIsCalledAndApiParametersAreInvalidShouldReturnInvalidUrl() {
        // GIVEN
        let expectation = self.expectation(description: "Data request should succeed")

        let originalURL = generateOriginalUrl(timestamp: timestamp!)
        
        let expectedUrlQueries = generateUrlQueries(using: URL(string: "https://gateway.marvel.com/v10/private/characters?publicKeeey=2")!, timestamp: timestamp!)

        var mock = Mock(url: originalURL!, dataType: .json, statusCode: 200, data: [.get: mockedData!])

        // WHEN
        sut?.callApi(requestType: .get, queryParameters: ["limit": 10, "offset": 10]) { _ in }
        
        mock.onRequest = { request, _ in
            let urlWithoutQuery = request.url?.absoluteString.replacingOccurrences(of: request.url!.query!, with: "")
            
            // THEN
            XCTAssertNotEqual(urlWithoutQuery, "https://gateway.marvel.com/v10/private/characters?")
            XCTAssertNotEqual(request.url?.query, expectedUrlQueries)

            expectation.fulfill()
        }
        
        mock.register()

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // MARK: - Helper functions

    private func generateOriginalUrl(timestamp: Int64) -> URL? {
        return Api(
            base: "https://gateway.marvel.com/",
            version: "v1/",
            resource: "public/",
            endpoint: "characters",
            publicKey: "da3e69b0df701145c835dfce4d351007",
            privateKey: "dc603d1dd158c1d5d7781b31e11c243946a5312f",
            queryParameters: ["limit": 10, "offset": 10],
            timestamp: timestamp
        ).url()
    }

    private func generateUrlQueries(using url: URL, timestamp: Int64) -> String {
        let fullUrlString = url.absoluteString.components(separatedBy: "?")
        return fullUrlString[1]
    }
    
    private func configureAlamofireMockedSession() -> Alamofire.Session {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        return Alamofire.Session(configuration: configuration)
    }
}
