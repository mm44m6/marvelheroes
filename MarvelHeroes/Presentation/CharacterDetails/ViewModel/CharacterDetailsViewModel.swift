//
//  CharacterDetailsViewModel.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 02/06/22.
//

import Foundation

protocol CharacterDetailsViewModelProtocol {
    func createImageData(character: Character) -> Data?
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    func createImageData(character: Character) -> Data? {
        guard let imageUrl = character.thumbnail.generateThumbnailUrl(imageVariant: .landscapeXlarge)  else { return nil }

        do {
            return try Data(contentsOf: imageUrl)
        } catch {
            return nil
        }
    }
}
