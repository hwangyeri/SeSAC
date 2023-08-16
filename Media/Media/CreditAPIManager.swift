//
//  CreditAPIManager.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreditAPIManager {
    static let shared = CreditAPIManager()
    
    private init() { }
    
//    func callRequest(movieId: Int, resultString: @escaping (Trand) -> Void) {
//        let url = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(APIKey.tmdbKey)"
//        let header: HTTPHeaders = [
//            "accept": "application/json",
//            "Authorization": "Bearer \(APIKey.tmdbKey)"
//        ]
//        
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
//            .responseDecodable(of: BoxOffice.self) { response in
//           
//        }
//    }
    
}
