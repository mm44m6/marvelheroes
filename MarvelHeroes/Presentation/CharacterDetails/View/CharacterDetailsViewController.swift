//
//  CharacterDetailViewController.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 31/05/22.
//

import Foundation
import UIKit

protocol CharacterDetailsViewControllerDelegate: AnyObject {
    func navigateToCharactersList()
}

class CharacterDetailsViewController: UIViewController {
    var delegate: CharacterDetailsViewControllerDelegate?
    var character: Character!
    private var viewModel: CharacterDetailsViewModelProtocol?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let characterImageHeader = UIImageView()
    private let characterNameLabel = UILabel()
    private let characterDescriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterDetailsViewModel()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 500)
    }

    private func setupView() {
        view.backgroundColor = .white

        setupScrollView()
        setupCharacterHeaderImageView()
        setupCharacterNameLabelView()
        setupCharacterDescriptionLabelView()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterHeaderImageView() {
        guard let imageData = viewModel?.createImageData(character: character) else {
            return
        }

        scrollView.addSubview(characterImageHeader)

        characterImageHeader.translatesAutoresizingMaskIntoConstraints = false

        characterImageHeader.image = UIImage(data: imageData)

        characterImageHeader.contentMode = .scaleAspectFill
        characterImageHeader.clipsToBounds = true

        let constraints = [
            characterImageHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            characterImageHeader.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            characterImageHeader.topAnchor.constraint(equalTo: scrollView.topAnchor),
            characterImageHeader.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            characterImageHeader.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterNameLabelView() {
        scrollView.addSubview(characterNameLabel)

        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false

        characterNameLabel.text = "\(character.name)"

        characterNameLabel.numberOfLines = 0
        characterNameLabel.font = .systemFont(ofSize: 32, weight: .heavy)
        characterNameLabel.sizeToFit()

        let constraints = [
            characterNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            characterNameLabel.topAnchor.constraint(equalTo: characterImageHeader.bottomAnchor),
            characterNameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterDescriptionLabelView() {
        scrollView.addSubview(characterDescriptionLabel)

        characterDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        characterDescriptionLabel.text = "\(character.getDescription)"

        characterDescriptionLabel.numberOfLines = 0
        characterDescriptionLabel.font = .systemFont(ofSize: 18, weight: .light)

        let constraints = [
            characterDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            characterDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            characterDescriptionLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterDescriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
