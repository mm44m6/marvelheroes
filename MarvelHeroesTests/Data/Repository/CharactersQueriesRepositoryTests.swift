//
//  CharactersQueriesRepository.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 07/06/22.
//

import Foundation

import XCTest
import RxCocoa
import RxBlocking

@testable import MarvelHeroes

class CharactersQueriesRepositoryTests: XCTestCase {
    // MARK: Tests configs
    var sut: CharactersQueriesRepositoryProtocol?
    var networkApiClientMock: NetworkApiClientMock?
    
    override func setUp() {
        networkApiClientMock = NetworkApiClientMock()
        sut = CharactersQueriesRepository(networkApiClient: networkApiClientMock!)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        networkApiClientMock = nil
        super.tearDown()
    }
    
    //MARK: - fetchCharactersList tests
    func testWhenApiResponseIsSuccessAndResposeHasDataShouldReturnListOfCharacters() {
        //GIVEN
        let expectation = self.expectation(description: "Data request should succeed")
        let expectedResponse = CharactersMock.createMockedCharactersList()
        
        //WHEN
        sut!.fetchCharactersList(limit: 30,
                                 offset: 30) { apiResponse in
            
            switch apiResponse {
            case .success(let characters):
                // THEN
                XCTAssertEqual(expectedResponse, characters)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiResponseIsSuccessAndResposeDoesntHaveDataShouldReturnError() {
        //GIVEN
        let expectation = self.expectation(description: "Data request should fail")
        let networkApiClientMock = NetworkApiClientMock(shouldReturnData: false)
        let sut = CharactersQueriesRepository(networkApiClient: networkApiClientMock)
        let expectedError = NetworkError.noDataReturned
        
        //WHEN
        sut.fetchCharactersList(limit: 30,
                                offset: 30) { apiResponse in
            
            switch apiResponse {
            case .success(let characters):
                XCTFail("Expected to be a failure but got a success with \(characters)")
                expectation.fulfill()
            case .failure(let error):
                // THEN
                XCTAssertNotNil(error)
                XCTAssertEqual(expectedError, error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiResponseIsSuccessIsFalseAndErrorWasReturnedShouldReturnApiResponseError() {
        //GIVEN
        let expectation = self.expectation(description: "Data request should fail")
        let networkApiClientMock = NetworkApiClientMock(shouldReturnError: true,
                                                        networkError: .unableToDecodeData)
        let sut = CharactersQueriesRepository(networkApiClient: networkApiClientMock)
        let expectedError = NetworkError.unableToDecodeData
        
        //WHEN
        sut.fetchCharactersList(limit: 30,
                                offset: 30) { apiResponse in
            
            switch apiResponse {
            case .success(let characters):
                XCTFail("Expected to be a failure but got a success with \(characters)")
            case .failure(let error):
                // THEN
                XCTAssertNotNil(error)
                XCTAssertEqual(expectedError, error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testWhenApiResponseIsSuccessIsFalseAndErrorWasNotReturnedShouldReturnUnknowError() {
        //GIVEN
        let expectation = self.expectation(description: "Data request should fail")
        let networkApiClientMock = NetworkApiClientMock(shouldReturnError: true)
        let sut = CharactersQueriesRepository(networkApiClient: networkApiClientMock)
        let expectedError = NetworkError.unkownNetworkError
        
        //WHEN
        sut.fetchCharactersList(limit: 30,
                                offset: 30) { apiResponse in
            
            switch apiResponse {
            case .success(let characters):
                XCTFail("Expected to be a failure but got a success with \(characters)")
            case .failure(let error):
                // THEN
                XCTAssertNotNil(error)
                XCTAssertEqual(expectedError, error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}
