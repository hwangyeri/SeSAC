//
//  APIService.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/30.
//

import Foundation

class APIService {
    
    private init() { } // 클래스는 외부에서 인스턴스 만들 수 있기때문에 외부에서 사용하지 못하게 접근 수준을 높이기, 명시적으로 접근 제어 추가 // 이제 APIService() <- 못함
    
    static let shared = APIService() //인스턴스 생성 방지 // 외부에서 생성이 안되게끔 함, Singleton Patten
    
    func callRequest() {
        
        let url = URL(string:
                        "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data: ", data)
            
            let value = String(data: data!, encoding: .utf8) // 데이터 형식을 변환해주는 기능
            
            print("value: ", value)
            
            print("response: ", response)
            print("error: ", error)
            
        }.resume()
        
    }
    
}
