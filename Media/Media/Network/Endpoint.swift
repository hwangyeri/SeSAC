//
//  Endpoint.swift
//  Media
//
//  Created by 황예리 on 2023/09/03.
//

import Foundation

enum Endpoint {
    case all
    case tv
    case movie
    case person
    
    var requestURL: String {
        
        switch self {
        case .all: return URL.makeEndPointString("all/day?api_key=\(APIKey.tmdbKey)")
        case .tv: return URL.makeEndPointString("tv/day?api_key=\(APIKey.tmdbKey)")
        case .movie: return URL.makeEndPointString("movie/day?api_key=\(APIKey.tmdbKey)")
        case .person: return URL.makeEndPointString("person/day?api_key=\(APIKey.tmdbKey)")
        }
        
    }
    
    
}
