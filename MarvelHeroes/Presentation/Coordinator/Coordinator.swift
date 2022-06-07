//
//  Coordinator.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import Foundation
import UIKit

protocol Coordinator {
    init(navigationController: UINavigationController,
         childViewControllers: [UIViewController])
    func start()
}
