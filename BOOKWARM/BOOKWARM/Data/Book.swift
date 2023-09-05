//
//  Book.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/09/04.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    var documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let thumbnail: String?
    let title: String
    let url: String
    var liked: Bool = false
    let status: String
    
    var authorsDescriptions: String {
        get {
            if authors.count == 1 {
                return authors.first!
            } else {
                if authors.isEmpty { return "" }
                return "\(authors[0]) 외 \(authors.count - 1)명"
            }
        }
    }
    
    var description: String {
        get {
            return "\(authorsDescriptions) · \(publisher) · \(price)"
        }
    }

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, price, publisher, status
        case salePrice = "sale_price"
        case thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
    }
}
