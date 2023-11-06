//
//  iTunesAPIManager.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/06.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invaildURL
    case unKnown
    case statusError
}

class iTunesAPIManager {
    
    static func fetchData(query: String) -> Observable<SearchAppModel> {
        
        return Observable<SearchAppModel>.create { value in
            
            let urlString = "https://itunes.apple.com/search?term=\(query)&country=KR&media=software&lang=ko_KR&limit=10"
            
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invaildURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("URLSession Succeed")
                
                if let _ = error {
                    value.onError(APIError.unKnown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                // JSON 디코딩 된 모델값 넘겨주기
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
            }
            .resume()
            
            return Disposables.create()
        }
    }
    
}
