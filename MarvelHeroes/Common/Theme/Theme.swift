//
//  AppAppearance.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 06/06/22.
//

import Foundation
import UIKit

struct Theme {
    static var backgroundColor: UIColor = .white
    static var cellBorderColor: UIColor = .gray

    // Text
    static var defaultTextColor: UIColor? = .black
    static var defaultTextFont: UIFont? = .systemFont(ofSize: FontSizes.medium.rawValue)

    static var titleTextFont: UIFont? = .systemFont(ofSize: FontSizes.large.rawValue)
}

enum FontSizes: CGFloat {
    case extraSmall = 8
    case small = 10
    case medium = 16
    case large = 20
    case extraLarge = 26
}
