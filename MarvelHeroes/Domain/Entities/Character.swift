//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation
import UIKit

// MARK: - Character
struct Character: Codable, Equatable {
    let id: Int
    let name, modified, resourceURI, description: String
    let thumbnail: Thumbnail
    let comics: Comics

    var getDescription: String {
        if self.description.isEmpty {
            return String(localized: "characters_empty_description_text")
        }

        return self.description
    }
}

// MARK: - Comics
struct Comics: Codable, Equatable {
    let available: Int
    let collectionURI: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable, Equatable {
    let resourceURI, name: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Equatable {
    let path, thumbnailExtension: String
    let imageVariant: ImageVariants?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
        case imageVariant
    }

    func generateThumbnailUrl(imageVariant: ImageVariants) -> URL? {
        let urlString = "\(path)/\(imageVariant.description).\(thumbnailExtension)"

        guard let url = URL(string: urlString) else { return nil }

        return url
    }
}
