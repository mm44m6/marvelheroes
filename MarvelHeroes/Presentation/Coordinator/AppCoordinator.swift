//
//  AppCoordinator.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController

    private var childViewControllers: [UIViewController]

    init(navigationController: UINavigationController,
         childViewControllers: [UIViewController] = []) {
        self.navigationController = navigationController
        self.childViewControllers = childViewControllers
    }

    func start() {
        showCharactersList()
    }

    private func showCharactersList() {
        let viewModel = CharactersListViewModel()
        let viewController = CharactersListViewController(viewModel: viewModel)

        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }

    private func showCharacterDetails(with character: Character) {
        let viewModel = CharacterDetailsViewModel()
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        viewController.delegate = self
        viewModel.character.accept(character)

        self.childViewControllers.append(viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension AppCoordinator: CharactersListViewControllerDelegate, CharacterDetailsViewControllerDelegate {
    func navigateToCharactersList() {
        showCharactersList()
    }

    func navigateToCharacterDetails(with character: Character) {
        showCharacterDetails(with: character)
    }
}
