//
//  UIImageView.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 06/06/22.
//

import Foundation

import Kingfisher
import UIKit

extension UIImageView {
    func cancelDownloading() {
        kf.cancelDownloadTask()
    }

    func download(image url: URL?) {
        guard let url = url else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
