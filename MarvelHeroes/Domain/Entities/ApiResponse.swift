//
//  ApiResponse.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 05/06/22.
//

import UIKit

class ApiResponse {
    var success: Bool
    var error: NetworkError?
    var data: AnyObject?
    init(success: Bool, error: NetworkError? = nil, data: AnyObject? = nil) {
        self.success = success
        self.error = error
        self.data = data
    }
}
