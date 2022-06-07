//
//  AppAppearance.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 06/06/22.
//

import Foundation
import UIKit

struct Theme {
    static var backgroundColor: UIColor?
    static var buttonBackgroundColor: UIColor?
    static var textColor: UIColor?
    static var textFont: UIFont?

    // Text
    static var defaultTextColor: UIColor? = .black
    static var defaultTextFont: UIFont? = .systemFont(ofSize: FontSizes.medium.rawValue)

    static var titleTextFont: UIFont? = .systemFont(ofSize: FontSizes.large.rawValue)

    public static func defaultTheme() {
        self.backgroundColor = UIColor.white
        self.buttonBackgroundColor = UIColor.white
        self.textColor = UIColor.black
        self.textFont = .systemFont(ofSize: 40)
    }
}

enum FontSizes: CGFloat {
    case extraSmall = 8
    case small = 10
    case medium = 16
    case large = 20
    case extraLarge = 26
}
