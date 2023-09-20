//
//  BeerRouter.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation
import Alamofire

enum BeerRouter: URLRequestConvertible {
    
    case getBeers
    case singleBeer
    case randomBeer
    
    private var baseURL: URL {
        return URL(string: "https://api.punkapi.com/v2/beers/")!
    }
    
    private var path: String {
        switch self {
        case .getBeers:
            return ""
        case .singleBeer:
            return "1"
        case .randomBeer:
            return "random"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        return request
    }
    
}
