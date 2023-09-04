//
//  URL+Extension.swift
//  Media
//
//  Created by 황예리 on 2023/09/03.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/trending/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
