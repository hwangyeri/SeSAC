//
//  BeerAPI.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation
import Alamofire

enum BeerAPI {
    
    case getBeers
    case singleBeer
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/beers"
    }
    
    var endPoint: URL {
        switch self {
        case .getBeers:
            return URL(string: baseURL)!
        case .singleBeer:
            return URL(string: baseURL + "/1")!
        case .randomBeer:
            return URL(string: baseURL + "/random")!
        }
    }
    
}
