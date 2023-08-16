//
//  TrandAPIManager.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

//import Foundation
//import Alamofire
//import SwiftyJSON
//
////genreAPI - https://api.themoviedb.org/3/genre/movie/list?api_key=\()
//
//class TrandAPIManager {
//    
//    static let shared = TrandAPIManager()
//    
//    private init() { }
//
//    func callRequest() {
//        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.tmdbKey)"
//        let header: HTTPHeaders = [
//            "accept": "application/json",
//            "Authorization": "Bearer \(APIKey.tmdbKey)"
//        ]
//        
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
//            .responseDecodable(of: BoxOffice.self) { response in
//                
//                guard let value = response.value else { return }
//                print(value.results)
//        }
//    }
//    
//}
