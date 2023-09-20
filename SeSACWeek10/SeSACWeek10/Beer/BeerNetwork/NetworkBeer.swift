//
//  NetworkBeer.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation
import Alamofire

final class NetworkBeer {
    
    static let shared = NetworkBeer()
    
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: BeerRouter, completion: @escaping (Result<T, SeSACError>) -> Void ) {
        
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
    func request<T: Decodable>(type: T.Type, api: BeerAPI, completion: @escaping (Result<T, SeSACError>) -> Void ) {
        AF.request(api.endPoint).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
}
