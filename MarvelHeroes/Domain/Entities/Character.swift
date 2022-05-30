//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 29/05/22.
//

import Foundation
import UIKit

struct Character: Equatable, Identifiable {
    typealias Identifier = String
    
    let id: Identifier
    let name: String
    let description: String
    let modified: Date
    let thumbnail: UIImage
}

struct Characters {
    let list: [Character]
}
