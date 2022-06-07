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
    let name, modified, resourceURI: String
    let description: String
    let thumbnail: Thumbnail
    let comics: Comics

    var getDescription: String {
        if self.description.isEmpty {
            return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ut rhoncus diam. Duis placerat tortor nibh, et fermentum lorem vestibulum in. Duis hendrerit pulvinar diam, nec pretium ligula tristique sit amet. Proin varius enim nulla, id faucibus sem commodo et. Integer in augue hendrerit, eleifend tellus mattis, vulputate diam. Curabitur faucibus elit ut accumsan aliquet. Morbi auctor mauris et ipsum feugiat pulvinar. Morbi id fringilla est, et ultrices odio. Vivamus id tortor et tortor dapibus cursus et ultrices erat. Fusce ac urna id ante semper suscipit in vitae erat. In urna tortor, gravida nec nibh eget, molestie sagittis justo. Quisque nec justo sapien. Suspendisse ultricies ante tellus, aliquet vulputate felis facilisis ut. Nam vulputate felis id imperdiet accumsan. Integer molestie ex at nisi bibendum cursus. Nullam non efficitur metus. Ut malesuada massa non laoreet posuere. Quisque luctus at lacus vel ornare. Sed vel dapibus augue. Fusce vel efficitur augue, interdum porta tellus. In sollicitudin porta fringilla. Morbi ac magna sollicitudin, cursus eros in, ultricies nulla. Maecenas non purus feugiat, tincidunt lorem ac, pulvinar magna. Donec at neque vitae metus fringilla vulputate. Nullam et sem velit. Nam in aliquam orci. Cras ornare ut erat vitae ultricies."
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
    let resourceURI: String
    let name: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Equatable {
    let path: String
    let thumbnailExtension: String
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
