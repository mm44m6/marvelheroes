//
//  CharactersMock.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 03/06/22.
//

import Foundation
@testable import MarvelHeroes

class CharactersMock {
    static func createMockedCharactersList() -> [Character] {
        var mockedCharactersList: [Character] = []
        mockedCharactersList.append(createMockedCharacters(name: "Spiderman", id: 20))
        mockedCharactersList.append(createMockedCharacters(name: "Daredevil"))
        mockedCharactersList.append(createMockedCharacters(name: "Doctor Strange"))
        return mockedCharactersList
    }
    
    static func createMockedCharacters(name: String, id: Int = Int.random(in: 21..<50)) -> Character {
        let mockedThumbnail = Thumbnail(
            path: "www.mocked.com",
            thumbnailExtension: "jpg",
            imageVariant: .landscapeAmazing
        )
        
        let mockedItem = Item(
            resourceURI: "",
            name: ""
        )
        
        let mockedComics = Comics (
            available: 123,
            collectionURI: "",
            items: [mockedItem]
        )
        
        return Character(id: id,
                  name: name,
                         modified: "",
                         resourceURI: "",
                         description: "",
                  thumbnail: mockedThumbnail,
                  comics: mockedComics)
    }
}
