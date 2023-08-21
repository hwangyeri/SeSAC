//
//  SimilarAPIManager.swift
//  Media
//
//  Created by 황예리 on 2023/08/21.
//

import Foundation
import Alamofire

class SimilarAPIManager {
    
    static let shared = SimilarAPIManager()
    
    private init() { }
    
    func callRequest(movieID: Int, success: @escaping (Similar) -> Void, failure: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=\(APIKey.tmdbKey)"
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(APIKey.tmdbKey)"
        ]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Similar.self) { response in
                
                switch response.result {
                case .success(let value): success(value)
                case.failure(let error): failure()
                    print(error)
                }
           
        }
    }
    
}


