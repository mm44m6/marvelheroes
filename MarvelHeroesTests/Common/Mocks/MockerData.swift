//
//  MockData.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 06/06/22.
//

import Foundation

public final class MockerData {
    public static let charactersList: URL = Bundle.module.url(forResource: "character_list", withExtension: "json")!
}

extension Bundle {
#if !SWIFT_PACKAGE
    static let module = Bundle(for: MockerData.self)
#endif
}

internal extension URL {
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
