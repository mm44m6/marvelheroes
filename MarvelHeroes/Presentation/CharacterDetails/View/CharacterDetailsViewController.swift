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
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let uiImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterDetailsViewModel()
        setupView()
        setupScrollView()
        setupViews()
        headerImage.image = createImage()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews() {
        contentView.addSubview(headerImage)
        headerImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        headerImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        headerImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.text = "\(character.name) "
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 5).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4/5).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.text = "\(character.description)"
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4/5).isActive = true
    }
    
    let headerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    func createImage() -> UIImage? {
        var image: UIImage?
        let urlString = "\(character.thumbnail.path)/portrait_uncanny.\(character.thumbnail.thumbnailExtension)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            image = UIImage(data: data)
            
        } catch {
            print(error)
        }
        
        return image
    }
}
