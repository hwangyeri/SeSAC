//
//  LottoAPIService.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/13.
//

import Foundation

class LottoAPIService {
    
    static let shared = LottoAPIService()
    
    private init() { }
    
    func callRequest(number: Int, completionHandler: @escaping (Lotto?, Error?) -> Void) {
        
        guard let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                    completionHandler(nil, error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    print("Invalid response")
                    completionHandler(nil, error)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completionHandler(nil, error)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completionHandler(result, error)
                    print(result, "----- result End -----")
                    
                } catch {
                    print("Error decoding data: \(error)")
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }
    
    
}
