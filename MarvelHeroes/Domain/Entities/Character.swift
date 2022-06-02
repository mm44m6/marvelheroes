//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation
import UIKit

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name, description, modified, resourceURI: String
    let thumbnail: Thumbnail
    let comics: Comics
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    let imageVariant: ImageVariants?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
        case imageVariant
    }
}

