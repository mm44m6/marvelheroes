//
//  MarvelHeroesTests.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import XCTest
import RxCocoa
import RxBlocking

@testable import MarvelHeroes

class CharactersListViewModelTests: XCTestCase {
    // MARK: Tests configs
    var sut: CharactersListViewModelProtocol?
    var fetchCharacterUseCaseMock: FetchCharactersUseCaseProtocol?
    
    override func setUp() {
        fetchCharacterUseCaseMock = FetchCharactersUseCaseMock()
        sut = CharactersListViewModel(fetchCharactersUseCase: fetchCharacterUseCaseMock!)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        fetchCharacterUseCaseMock = nil
        super.tearDown()
    }
    
    //MARK: - filterSearchQuery tests
    func testWhenSearchQueryIsEnteredFilterQuerySearchFunctionShouldReturnFilteredList() {
        // Given
        let searchQuery = "Spi"
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let expectedFilteredCharacters = [CharactersMock.createMockedCharacters(name: "Spiderman", id: 20)]
        
        // When
        let resultedFilteredCharacters = sut?.filterSearchQuery(query: searchQuery, characters: charactersMockedList)

        // Then
        XCTAssertEqual(expectedFilteredCharacters, resultedFilteredCharacters)
    }
    
    func testWhenSearchQueryMatchesAnyCharacterSearchErrorObservableShouldNotRecieveValue() {
        // Given
        let searchQuery = "Spi"
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let expectedFilteredCharacters = [CharactersMock.createMockedCharacters(name: "Spiderman", id: 20)]
        
        // When
        let resultedFilteredCharacters = sut?.filterSearchQuery(query: searchQuery, characters: charactersMockedList)

        // Then
        XCTAssertNil(try! sut?.searchError.toBlocking().first()!)
        XCTAssertEqual(expectedFilteredCharacters, resultedFilteredCharacters)
    }
    
    func testWhenSearchQueryDoesNotMatchAnyCharacterFilterQuerySearchFunctionShouldReturnEmptyList() {
        // Given
        let searchQuery = "Test wont find this"
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let expectedFilteredCharacters: [Character?] = []
        
        // When
        let resultedFilteredCharacters = sut?.filterSearchQuery(query: searchQuery, characters: charactersMockedList)

        // Then
        XCTAssertEqual(expectedFilteredCharacters, resultedFilteredCharacters)
    }
    
    func testWhenSearchQueryDoesNotMatchAnyCharacterFilterSearchErrorObservableShouldRecieveValue() {
        // Given
        let searchQuery = "Test wont find this"
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let expectedStreamValue = SearchError.notFound
        
        // When
        _ = sut?.filterSearchQuery(query: searchQuery, characters: charactersMockedList)

        // Then
        let recievedStreamValue = try! sut?.searchError.toBlocking().first()
        XCTAssertEqual(expectedStreamValue, recievedStreamValue)
    }
    
    func testWhenSearchQueryIsEmptyFilterQuerySearchFunctionShouldReturnCharactersList() {
        // Given
        let searchQuery = ""
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let expectedFilteredCharacters = charactersMockedList
        
        // When
        let resultedFilteredCharacters = sut?.filterSearchQuery(query: searchQuery, characters: charactersMockedList)

        // Then
        XCTAssertEqual(expectedFilteredCharacters, resultedFilteredCharacters)
    }
    
    // MARK: - handleInfiniteScroll tests
    
    func testWhenCurrentRowIsTheLastElementAndLoadingsAreFalseShouldFetchMoreCharacters() {
        // Given
        let fetchCharactersUseCaseMock = FetchCharactersUseCaseMock()
        let sut = CharactersListViewModel(fetchCharactersUseCase: fetchCharactersUseCaseMock)
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let currentRowIndex = charactersMockedList.count - 1
        sut.characters.accept(charactersMockedList)
        sut.isFooterLoading.accept(false)
        sut.isFullScreenLoading.accept(false)
        
        // When
        sut.handleInfiniteScroll(currentRow: currentRowIndex)

        // Then
        XCTAssertTrue(fetchCharactersUseCaseMock.didExecuteFunction)
    }
    
    func testWhenCurrentRowIsTheLastElementAndIsFooterLoadingIsTrueShouldNotFetchMoreCharacters() {
        // Given
        let fetchCharactersUseCaseMock = FetchCharactersUseCaseMock()
        let sut = CharactersListViewModel(fetchCharactersUseCase: fetchCharactersUseCaseMock)
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let currentRowIndex = charactersMockedList.count - 1
        sut.characters.accept(charactersMockedList)
        sut.isFooterLoading.accept(true)
        
        // When
        sut.handleInfiniteScroll(currentRow: currentRowIndex)

        // Then
        XCTAssertFalse(fetchCharactersUseCaseMock.didExecuteFunction)
    }
    
    func testWhenCurrentRowIsTheLastElementAndIsFullScreenLoadingIsTrueShouldNotFetchMoreCharacters() {
        // Given
        let fetchCharactersUseCaseMock = FetchCharactersUseCaseMock()
        let sut = CharactersListViewModel(fetchCharactersUseCase: fetchCharactersUseCaseMock)
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let currentRowIndex = charactersMockedList.count - 1
        sut.characters.accept(charactersMockedList)
        sut.isFullScreenLoading.accept(true)
        
        // When
        sut.handleInfiniteScroll(currentRow: currentRowIndex)

        // Then
        XCTAssertFalse(fetchCharactersUseCaseMock.didExecuteFunction)
    }
    
    func testWhenCurrentRowIsNotTheLastElementShouldNotFetchMoreCharacters() {
        // Given
        let fetchCharactersUseCaseMock = FetchCharactersUseCaseMock()
        let sut = CharactersListViewModel(fetchCharactersUseCase: fetchCharactersUseCaseMock)
        let charactersMockedList = CharactersMock.createMockedCharactersList()
        let currentRowIndex = charactersMockedList.count - 2
        sut.characters.accept(charactersMockedList)
        sut.isFooterLoading.accept(true)
        sut.isFullScreenLoading.accept(true)
        
        // When
        sut.handleInfiniteScroll(currentRow: currentRowIndex)

        // Then
        XCTAssertFalse(fetchCharactersUseCaseMock.didExecuteFunction)
    }
}
