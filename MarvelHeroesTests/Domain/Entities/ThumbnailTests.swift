//
//  ThumbnailTests.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 05/06/22.
//

import Foundation

import XCTest

@testable import MarvelHeroes

class ThumbnailTests: XCTestCase {

    //MARK: - generateThumbnailUrl tests
    func testWhenAllParametersAreProvidedShouldReturnThumbnailUrl() {
        // Given
        let sut = Thumbnail(path: "https://testpath.com.br",
                            thumbnailExtension: "jpg",
                            imageVariant: nil)
        
        let expectedThumbnailUrl = URL(string: "https://testpath.com.br/landscape_amazing.jpg")
        
        // When
        let resultedThumbnailUrl = sut.generateThumbnailUrl(imageVariant: .landscapeAmazing)

        // Then
        XCTAssertEqual(expectedThumbnailUrl, resultedThumbnailUrl)
    }
    
    func testWhenParametersAreInvalidShouldReturnNil() {
        // Given
        let sut = Thumbnail(path: "not a url",
                            thumbnailExtension: "jpg",
                            imageVariant: nil)
        
        // When
        let resultedThumbnailUrl = sut.generateThumbnailUrl(imageVariant: .landscapeAmazing)

        // Then
        XCTAssertNil(resultedThumbnailUrl)
    }
}
