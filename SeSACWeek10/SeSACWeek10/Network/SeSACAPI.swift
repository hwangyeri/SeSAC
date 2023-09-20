//
//  SeSACAPI.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/19.
//

import Foundation
import Alamofire

// Alamofire -> Moya
// URLRequestConvertible: 구조 강제화, 커뮤니케이션에 용이, 어떤 구조로 이루어졌겠거니 유추가 가능함

//enum Router: URLRequestConvertible { // Moya 를 사용하지 않아도 유추가능
//
//}

enum SeSACAPI {
    
    // 열거형 하나에 모든 네트워크 통신을 하기 위해서 필요한 정보을 뭉쳐서 만듦
    // 장점 1. 네트워크 통신 구조를 한눈에 파악할 수 있음
    // 장점 2. 네트워크 구조를 잘 만들어두면 유지보수하기 쉬움
    
    private static let key = "lnTDngWfnuzPLFCjTP-ADeQvZ4LrJe09qmyUPEG_2yI" // key 는 .gitignore 처리해도 됨
    
    case search(query: String)
    case random
    case photo(id: String) // 연관값, associated value
    
    private var baseURL: String { // private 로 제약을 걸어둔 순간, 이 공간에서만 빌드가 가능하기 때문에 메모리를 아낄 수 있음, 성능 측면에서 좋음
//        switch self { // baseURL 은 하나로 고정되어 있진 않다!
//        case .search, .random:
//            return "https://api.unsplash.com/"
//        case .photo:
//            return "https://api.unsplash.com/"
//        }
        return "https://api.unsplash.com/"
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod {
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

}
