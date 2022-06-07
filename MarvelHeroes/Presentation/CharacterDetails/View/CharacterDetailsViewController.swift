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
    private let characterImageHeader = UIImageView()
    private let characterNameLabel = UILabel()
    private let characterDescriptionLabel = UITextView()
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterDetailsViewModel()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)

        characterDescriptionLabel.text = "\(character.getDescription)"
    }

    private func setupView() {
        view.backgroundColor = .white

        setupScrollView()
        setupContainerView()
        setupCharacterHeaderImageView()
        setupCharacterNameLabelView()
        setupCharacterDescriptionLabelView()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.automaticallyAdjustsScrollIndicatorInsets = true

        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupContainerView() {
        scrollView.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterHeaderImageView() {
        guard let imageData = viewModel?.createImageData(character: character) else {
            return
        }

        containerView.addSubview(characterImageHeader)

        characterImageHeader.translatesAutoresizingMaskIntoConstraints = false

        characterImageHeader.image = UIImage(data: imageData)

        characterImageHeader.contentMode = .scaleAspectFill
        characterImageHeader.clipsToBounds = true

        let constraints = [
            characterImageHeader.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            characterImageHeader.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            characterImageHeader.topAnchor.constraint(equalTo: containerView.topAnchor),
            characterImageHeader.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            characterImageHeader.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterNameLabelView() {
        containerView.addSubview(characterNameLabel)

        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterDescriptionLabel.textAlignment = .center

        characterNameLabel.text = "\(character.name)"
        characterNameLabel.clipsToBounds = true

        characterNameLabel.numberOfLines = 1
        characterNameLabel.font = .systemFont(ofSize: 32, weight: .heavy)
        characterNameLabel.baselineAdjustment = .alignCenters

        let constraints = [
            characterNameLabel.topAnchor.constraint(equalTo: characterImageHeader.bottomAnchor),
            characterNameLabel.widthAnchor.constraint(equalTo: characterNameLabel.widthAnchor),
            characterNameLabel.heightAnchor.constraint(equalTo: characterNameLabel.heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterDescriptionLabelView() {
        scrollView.addSubview(characterDescriptionLabel)

        characterDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        characterDescriptionLabel.font = .systemFont(ofSize: 18, weight: .light)

        characterDescriptionLabel.textAlignment = .justified

        characterDescriptionLabel.isScrollEnabled = false

        characterDescriptionLabel.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)

        let constraints = [
            characterDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            characterDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            characterDescriptionLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
