//
//  FetchCharactersUseCaseMock.swift
//  MarvelHeroesTests
//
//  Created by Maria Luiza Fornagieri on 04/06/22.
//

import Foundation
@testable import MarvelHeroes

class FetchCharactersUseCaseMock: FetchCharactersUseCaseProtocol {
    public var didExecuteFunction: Bool = false
    private var shouldFail: Bool = false
    private var shouldComplete: Bool = false
    
    func execute(limit: Int, offset: Int, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        if shouldFail {
            didExecuteFunction = false
        }
        
        if shouldComplete {
            let newCharactersMockedList = [CharactersMock.createMockedCharacters(name: "Hulk"),
                                           CharactersMock.createMockedCharacters(name: "Iron Man"),
                                           CharactersMock.createMockedCharacters(name: "Black Widow")]
            
            completion(.success(newCharactersMockedList))
        }
        
        didExecuteFunction = true
    }
}
