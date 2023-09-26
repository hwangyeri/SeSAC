//
//  Photo.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/27.
//

import Foundation

//Codable: Decodable + Encodable
struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

// Codable 이 아닌 Decodable 인 이유 => 가지고 와서 구조체에 넣어주고 있어서 Decodable 만 해도 충분!
struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable { // 0926 데이터 고유성을 보장하기 위해서 Hashable 추가
    let full: String
    let thumb: String
}
