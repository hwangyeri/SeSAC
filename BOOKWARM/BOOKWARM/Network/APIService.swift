//
//  APIService.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/09/04.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func searchBook(text: String, page: Int, completion: @escaping (Book?) -> Void ) {
        
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(text)&size=10&page=\(page)&client_id=\(APIKey.kakaoKey)") else { return }
        print(url)
    
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Book.self, from: data!)
                completion(result)
                
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}
