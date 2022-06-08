//
//  CharacterDetailsViewModel.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 02/06/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol CharacterDetailsViewModelProtocol {
    func createImageData(character: Character) -> Data?
    var character: BehaviorRelay<Character?> { get }
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    let character: BehaviorRelay<Character?> = BehaviorRelay(value: nil)

    func createImageData(character: Character) -> Data? {
        guard let imageUrl = character.thumbnail.generateThumbnailUrl(imageVariant: .landscapeXlarge)  else { return nil }

        do {
            return try Data(contentsOf: imageUrl)
        } catch {
            return nil
        }
    }
}
