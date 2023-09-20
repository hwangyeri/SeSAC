//
//  Beer.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation

typealias Beer = [BeerElement]

// MARK: - BeerElement
struct BeerElement: Codable {
    let id: Int
    let name, tagline, description: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case imageURL = "image_url"
    }
}
