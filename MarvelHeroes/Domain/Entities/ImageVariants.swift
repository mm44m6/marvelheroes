//
//  Thumbnail.swift
//  MarvelHeroes
//
//  Created by Maria Luiza Fornagieri on 02/06/22.
//

import Foundation

enum ImageVariants: String, Codable {
    // MARK: - Portraits
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXlarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"

    // MARK: - Standard
    case standardSmall = "standard_small"
    case standardMedium = "standard_medium"
    case standardLarge = "standard_large"
    case standardXlarge = "standard_xlarge"
    case standardFantastic = "standard_fantastic"
    case standardAmazing = "standard_amazing"

    // MARK: - Landscape
    case landscapeSmall = "landscape_small"
    case landscapeMedium = "landscape_medium"
    case landscapeLarge = "landscape_large"
    case landscapeXlarge = "landscape_xlarge"
    case landscapeAmazing = "landscape_amazing"
    case landscapeIncredible = "landscape_incredible"

    // MARK: - Description
    var description: String {
        return self.rawValue
    }
}
