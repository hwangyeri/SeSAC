//
//  TranslateAPIManager.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslateAPIManager { // 실질적으로 네트워크 요청하는 곳
    
    static let shared = TranslateAPIManager()
    
    private init() { }
    
    func callRequest(text: String, resultString: @escaping (String) -> Void) {
        // @escaping 탈출 주문, 함수 안에 함수가 있어서 탈출 시켜야되는 의무가 있음
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "\(APIKey.naverID)",
            "X-Naver-Client-Secret": "\(APIKey.naverKey)"
        ]
        let parameters: Parameters = [
            "source": "kr",
            "target": "en",
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                resultString(data)
                
            case .failure(let error):
                print(#function, error)
            }
            
        }
        
    }
    
}
