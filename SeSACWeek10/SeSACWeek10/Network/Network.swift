//
//  Network.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/19.
//

import Foundation
import Alamofire

// 제네릭 사용해서 어떤 타입이여도 받을 수 있는 큰 네모 박스로 리팩토링 <T>
// 어떤 API 를 호출하더라도 범용적으로 호출할 수 있게 만들기
// 디코딩 관련된 코드가 들어와야 안전함 => 디코딩 코드만 들어오게끔 제약조건 설정 <T: Decodable>
// T 가 어떤 것을 받을지 매개변수 자리 만들어주기 => type: T.Type
// "고래밥" > String > String.Type => 스트링은 무슨 타입이야? 스트링.타입이야

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, SeSACError>) -> Void ) {
        
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
    
    func request<T: Decodable>(type: T.Type, api: SeSACAPI, completion: @escaping (Result<T, SeSACError>) -> Void ) {
        
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.headers).responseDecodable(of: T.self) { response in // url 목적지
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_): // 연관값을 사용하지 않기때문에 _ 로 대체
                //guard let statusCode = response.response?.statusCode else { return }
                let statusCode = response.response?.statusCode ?? 500 // nil 값이면 500 던지기
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
}
