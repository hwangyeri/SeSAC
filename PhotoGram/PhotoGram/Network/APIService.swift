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
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        
        guard let url = URL(string:
                        "https://api.unsplash.com/search/photos?query=\(query)?sky&client_id=\(APIKey.unsplashAccessKey)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10) // 타임아웃 옵션 - 서버 응답이 10초안에 안되면 사용자가 다시 시도할 수 있도록 실패로 반환
        
        URLSession.shared.dataTask(with: request) { data, response, error in // 값이 있으면 error nil, 값이 없으면 data nil
            
            DispatchQueue.main.async { // 내부에 구현을 해두고 반복되는 코드를 줄임
                
                if let error = error { // error nil 이면 실행 X
                    //print("error: ", error)
                    completionHandler(nil) // 코드가 끝났음을 암시해줘야함, nil을 전달해서 정상적인 처리가 되지않았음을 알려줌
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    //print("response error: ", error) //Alert 또는 Do try Catch 등 사용자에게 띄워주는 과정이 필요
                    completionHandler(nil) // 올바르게 데이터가 안왔다는 것을 사용자에게 알려주는 것
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print("result: ", result)
                } catch {
                    //print("decode error: ", error) //디코딩 오류 키
                    completionHandler(nil)
                }
            }
            
            //let result = try? JSONDecoder().decode(, from: data)
            //let value = String(data: data!, encoding: .utf8) // 데이터 형식을 변환해주는 기능
        }.resume()
        
    }
    
}

// 퀵타임 쓰지않고 모델 직접 정의

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
