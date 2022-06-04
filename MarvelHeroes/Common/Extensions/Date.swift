//
//  Data.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 03/06/22.
//

import Foundation

extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
