//
//  NetworkBasic.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/19.
//

import Foundation
import Alamofire

// Error Protocol 을 Custom 해서 사용..?
// Alamofire 및 Result Type 을 활용해서 네트워크 모듈 추상화

enum SeSACError: Int, Error { // 상태 코드에 대한 대응
    case unauthorized = 401 // Error 라는 것을 인지하고 있기때문에 좀더 명확한 이름 사용 // ex. authorizedError -> unauthorized
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String { // 사용자에게 보여줄 상태 코드 에러 메세지
        switch self {
        case .unauthorized:
            return "인증 정보가 없습니다."
        case .permissionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
    
}

final class NetworkBasic { // final: 상속이 안됨, 이외에도 컴파일 타임에서 성능, 디스패치 기능
    
    static let shared = NetworkBasic() // 싱글턴 패턴
    
    private init() { } // 외부에서 초기화 할 수 없도록 막기
    
    // Search Photo
    func request(api: SeSACAPI, query: String, completion: @escaping (Result<Photo, SeSACError>) -> Void ) {
        //func request(query: String, completion: @escaping (Photo?, Error?) -> Void ) { // List 에 담아주기 위해서 completion 필요
       
        // (Photo?, Error?) => 왜 옵셔널로 받아야할까? => 두가지 값을 한 번에 받아야해서 옵셔널로 실행, 하나가 성공하면 하나가 실패함
        // 하지만 completion(nil, nil) 둘다 실패할 경우도 있음 (네트워크가 정상적으로 통신되면 Error 는 nil 값)
        // IF, 3가지 값이 들어가면 8가지의 경우의 수가 나옴...따라서 6가지 타입만 넣어주기 위해서 ResultType 을 활용
        // ResultType: 열거형으로 성공/실패 두가지 케이스만 다룸 + 옵셔널에 대한 문제 해결
        
        //let url = "https://api.unsplash.com/search/photos" // query 나 client_id 순서는 중요하지 않음
        //let headers: HTTPHeaders = ["Authorization": "Client-ID \(SeSACAPI.key)"] // headers 에 담아서 보내는게 더 안전함
        //let query: Parameters = ["query": query]
        
        // POST => 광범위한 데이터를 가져올 수 있음, Default 로 parameters 를 Body 에 담아서 보냄. Body: parameters
        // GET => 간소한 데이터만 가져올 수 있음, query String 은 제한이 있다. ex. 자릿수, 범위
        // Default 설정 값이 Body: parameters 이기 때문에 encoding 파라미터를 추가해서 queryString 로 설정 값을 바꾸는 작업이 필요
        
        //let api = SeSACAPI.search(query: query)
        
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.headers).responseDecodable(of: Photo.self) { response in // url 목적지
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_): // 연관값을 사용하지 않기떄문에 _ 로 대체
                //guard let statusCode = response.response?.statusCode else { return }
                let statusCode = response.response?.statusCode ?? 500 // nil 값이면 500 던지기
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
    // Random Photo
    func random(api: SeSACAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        
        AF.request(api.endPoint, method: api.method, headers: api.headers).responseDecodable(of: PhotoResult.self) { response in
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
    
    // Detail Photo (id)
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        
        AF.request(api.endPoint, method: api.method, headers: api.headers).responseDecodable(of: PhotoResult.self) { response in
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
