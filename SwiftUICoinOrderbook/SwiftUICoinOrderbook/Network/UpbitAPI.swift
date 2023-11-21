//
//  UpbitAPI.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/21.
//

import Foundation

struct Market: Hashable, Codable { // 데이터에 응답값을 넣으려면
    let market: String
    let korean: String
    let english: String // 스넬케이스 -> 카멜케이스, 커스텀 키를 사용하고 싶다면 코딩키 활용
    
    enum CodingKeys: String, CodingKey {
        case market // 모든 키를 다 써줘야함
        case korean = "korean_name"
        case english = "english_name"
    }
}

class UpbitAPI {
    
    private init() { }
    
    static func fetchAllMarket(completion: @escaping ([Market]) -> Void) { // @escaping을 통해서 Market 데이터를 밖으로 전달
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            //let decodedData = try? JSONDecoder().decode(Market.self, from: data)
            // 강제 연산자나 옵셔널로 해결하면 에러를 출력할 수 없음, do catch 해결해야함
            
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                //print(decodedData) // 서버에서 온 응답값을 우리의 구조체에 담았을 때의 결과, 서버 문제가 아님
                
                DispatchQueue.main.async {
                    completion(decodedData) // 성공적으로 응답을 받으면 decodedData 데이터 방출
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
