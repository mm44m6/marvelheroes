//
//  CharacterDetailsViewModelTests.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 06/06/22.
//

import XCTest

@testable import MarvelHeroes

class CharacterDetailsViewModelTests: XCTestCase {
    // MARK: Tests configs
    private var sut: CharacterDetailsViewModelProtocol?
    private var character: Character?
    
    override func setUp() {
        sut = CharacterDetailsViewModel()
        character = CharactersMock.createMockedCharacters(name: "Hulk")
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown() 
    }
    
    func testWhenCreateImageDataRecievesValidCharacterShouldGenerateThumbnailData() {
        // Given
        let expectedThumbnailData = "".data(using: .utf8)
        
        // When
        let resultedThumbnailData = sut?.createImageData(character: character!)

        // Then
        XCTAssertEqual(expectedThumbnailData, resultedThumbnailData)
    }
}
