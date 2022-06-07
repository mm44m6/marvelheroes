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
    static var buttonTextColor: UIColor?
    static var buttonBackgroundColor: UIColor?
    static var textColor: UIColor?
    static var textFont: UIFont?

    public static func defaultTheme() {
        self.backgroundColor = UIColor.white
        self.buttonTextColor = UIColor.red
        self.buttonBackgroundColor = UIColor.white
        self.textColor = UIColor.black
        self.textFont = .systemFont(ofSize: 40)
    }
}
