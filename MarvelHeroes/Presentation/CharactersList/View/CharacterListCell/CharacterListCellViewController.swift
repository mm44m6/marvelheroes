//
//  CharacterListCell.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 30/05/22.
//

import UIKit

class CharacterListCellViewController: UITableViewCell {
    var characterThumbnail: Thumbnail?
    let characterNameLabel = UILabel()
    let characterDescriptionLabel = UILabel()
    private let characterThumbnailImageView = UIImageView()
    private let characterStackView = UIStackView()

    override func prepareForReuse() {
        super.prepareForReuse()
        characterThumbnailImageView.image = nil
        characterThumbnailImageView.cancelDownloading()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        setupContentView()
        setupCharacterStackView()
        setupCharacterNameView()
    }

    func setupContentView() {
        let constraints = [
            contentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setupCharacterStackView() {
        contentView.addSubview(characterStackView)

        characterStackView.translatesAutoresizingMaskIntoConstraints = false

        characterStackView.axis = .horizontal
        characterStackView.distribution = .fillEqually
        characterStackView.alignment = .fill
        characterStackView.semanticContentAttribute = .forceRightToLeft

        let constraints = [
            characterStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            characterStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setupCharacterNameView() {
        let characterNameLabelContainerView = UIView()
        characterNameLabelContainerView.addSubview(characterNameLabel)
        characterStackView.addArrangedSubview(characterNameLabelContainerView)

        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false

        characterNameLabel.lineBreakMode = .byWordWrapping
        characterNameLabel.numberOfLines = 0
        characterNameLabel.textAlignment = .center
        characterNameLabel.font = Theme.defaultTextFont

        let constraints = [
            characterNameLabelContainerView.topAnchor.constraint(equalTo: characterNameLabel.topAnchor),
            characterNameLabelContainerView.bottomAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterNameLabelContainerView.trailingAnchor.constraint(equalTo: characterNameLabel.trailingAnchor),
            characterNameLabelContainerView.leadingAnchor.constraint(equalTo: characterNameLabel.leadingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setupCharacterThumbnailView() {
        characterStackView.addArrangedSubview(characterThumbnailImageView)
        characterThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false

        guard let characterThumbnailImageURL = characterThumbnail?.generateThumbnailUrl(imageVariant: .landscapeMedium) else { return }

        characterThumbnailImageView.download(image: characterThumbnailImageURL)

        characterThumbnailImageView.contentMode = .scaleAspectFill
        characterThumbnailImageView.clipsToBounds = true
        characterThumbnailImageView.layer.masksToBounds = true
        characterThumbnailImageView.layer.cornerRadius = 10
        characterThumbnailImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]

        let constraints = [
            characterThumbnailImageView.topAnchor.constraint(equalTo: characterStackView.topAnchor),
            characterThumbnailImageView.bottomAnchor.constraint(equalTo: characterStackView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
