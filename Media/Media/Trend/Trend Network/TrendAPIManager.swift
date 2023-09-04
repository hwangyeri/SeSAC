//
//  TrendAPIManager.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

import Foundation
import Alamofire

//genreAPI - https://api.themoviedb.org/3/genre/movie/list?api_key=\()

class TrendAPIManager {

    static let shared = TrendAPIManager()

    private init() { }

    func callRequest(type: Endpoint, success: @escaping (Trend) -> Void, failure: @escaping () -> Void) {
        //let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.tmdbKey)"
        let url = type.requestURL
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(APIKey.tmdbKey)"
        ]
        
        print(url, "===== url =====")

        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Trend.self) { response in
                
                switch response.result {
                case .success(let value): success(value)
                case.failure(let error): failure()
                    print(error)
                }
        }
    }

}
