//
//  Photo.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

struct Photo: Codable, Hashable { // Diffable 은 IndexPath 로 구성을 하는게 아니여서 Hashable 을 붙여서 고유해야함을 의미
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable, Hashable {
    let id: String
    let created_at: String
    let description: String?
    let urls: PhotoURL
    let links: PhotoLink
    let likes: Int
    let user: PhotoUser
}

struct PhotoURL: Codable, Hashable {
    let full: String
    let thumb: String
}

struct PhotoLink: Codable, Hashable {
    let html: String
}

struct PhotoUser: Codable, Hashable {
    let username: String
}

