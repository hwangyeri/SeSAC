//
//  Router.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation
import Alamofire

// 네트워트 라우터 패턴: 추상화, 모듈화 관리

enum Router: URLRequestConvertible { // 규격화, 양식에 맞춰서 작성
    
    private static let key = "lnTDngWfnuzPLFCjTP-ADeQvZ4LrJe09qmyUPEG_2yI"
    
    case search(query: String)
    case random
    case photo(id: String)
    
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    private var path: String {
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .photo(let id):
            return "photos/\(id)"
        }
    }
    
    private var headers: HTTPHeaders {
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .photo:
            return ["":""]
        }
    }
    
    func asURLRequest() throws -> URLRequest { // URLRequest 형태를 만들어서 던짐
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = headers
        request.method = method
        
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        return request
    }
    
    
}
