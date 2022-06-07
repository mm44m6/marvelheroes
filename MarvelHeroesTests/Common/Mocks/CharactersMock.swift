//
//  CharactersMock.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 03/06/22.
//

import Foundation
@testable import MarvelHeroes

class CharactersMock {
    static func createMockedCharactersList(ids: [Int]? = nil) -> [Character] {
        var mockedCharactersList: [Character] = []
        mockedCharactersList.append(createMockedCharacters(name: "Spiderman", id: ids?[0] ?? 20))
        mockedCharactersList.append(createMockedCharacters(name: "Daredevil", id: ids?[1] ?? 40))
        mockedCharactersList.append(createMockedCharacters(name: "Doctor Strange", id: ids?[2] ?? 50))
        return mockedCharactersList
    }
    
    static func createMockedMarvelDataResponse(
        offset: Int,
        limit: Int,
        results: [Character],
        code: Int,
        status: String
    ) -> MarvelDataResponse<CharactersResultContainer>{
        let characterResultContainer = CharactersResultContainer(
            offset: offset,
            limit: limit,
            total: 10,
            count: 10,
            results: results
        )

        return MarvelDataResponse(
            code: code,
            status: status,
            copyright: "© 2022 MARVEL",
            attributionText: "Data provided by Marvel. © 2022 MARVEL",
            attributionHTML: "<a href=\"http://marvel.com\">Data provided by Marvel. © 2022 MARVEL</a>",
            etag: "c356892a22d3f0aa06b319e9be6880445bdfabf9",
            data: characterResultContainer
        )
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
