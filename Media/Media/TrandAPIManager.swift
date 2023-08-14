//
//  TrandAPIManager.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

//genreAPI - https://api.themoviedb.org/3/genre/movie/list?api_key=\()

struct Trand {
    var trandPosterURL: String
    var trandTitle: String
    var trandDate: String
    var trandRate: Double
    var trandOverview: String
    var trandGenre: [Int]
}

class TrandAPIManager {
    
    static let shared = TrandAPIManager()
    
    private init() { }

    func callRequest(resultString: @escaping (Trand) -> Void) {
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.tmdbKey)"
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer e3bbc2e18bea5f66cc273eb1877145a0"
        ]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                if let trandData = json["results"].arrayValue.first {
                    
                    let poster = trandData["poster_path"].stringValue
                    let title = trandData["title"].stringValue
                    let date = trandData["release_date"].stringValue
                    let rate = trandData["vote_average"].doubleValue
                    let overview = trandData["overview"].stringValue
                    let genreList = trandData["genre_ids"].arrayValue.map { $0.intValue }
                    
                    let data = Trand(trandPosterURL: poster, trandTitle: title, trandDate: date, trandRate: rate, trandOverview: overview, trandGenre: genreList) //error
                    
                    resultString(data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
