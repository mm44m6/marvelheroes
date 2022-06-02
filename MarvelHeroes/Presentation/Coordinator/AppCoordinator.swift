//
//  AppCoordinator.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showCharacterList()
    }
    
    private func showCharacterList() {
        let viewController = CharacterListViewController()
        viewController.delegate = self
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showCharacterDetails() {
        let viewController = UIStoryboard(name: "CharacterDetailsViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        viewController.delegate = self
        navigationController.setViewControllers([viewController], animated: true)
    }
}

extension AppCoordinator: CharacterListViewControllerDelegate, CharacterDetailsViewControllerDelegate {
    func navigateToFirstPage() {
        showCharacterList()
    }
    
    func navigateToCharacterDetails() {
        showCharacterDetails()
    }
}
