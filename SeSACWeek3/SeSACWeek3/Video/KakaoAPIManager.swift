//
//  KakaoAPIManager.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakaoKey)"] // headers 노출이 조금 더 안전한 편
    
//    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (JSON) -> () ) {
//
//        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        // 한글에 대한 처리를 해야함, 옵셔널 바인딩 필요 // query 검색어를 인코딩으로 변환하는 작업
//        let url = type.requestURL + text
//        // page 웹에서 페이지 1번 2번 버튼 눌렀을때와 같은 처리
//
//        print(url) // 데이터가 잘 바뀌는지, 필요한 시점에 서버 통신이 잘 되는 지 확인
//
//        // ex. validate(statusCode: 200...500) 성공 코드로 보겠다~ 설정도 가능
//        // 상태 코드에 대한 처리, 예외처리에 대한 대응이 필요
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
//            switch response.result { // response 매개변수
//            case .success(let value):
//                let json = JSON(value) // 상태 코드에 따라서 달라짐
//
//               completionHandler(json)
//
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//
////        let url = Endpoint.video.requestURL
//
//    }
    
    func callRequest(type: Endpoint, query: String, success: @escaping (Video) -> Void, failure: @escaping () -> Void) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text
        
        print(url, "======= url ====")
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Video.self) { response in
                
                switch response.result {
                case .success(let value): success(value)
                    print(value, "====== request value ====")
                case.failure(let error): failure()
                    print(error, "====== request error =====")
                }
           
        }
    }
    
}
