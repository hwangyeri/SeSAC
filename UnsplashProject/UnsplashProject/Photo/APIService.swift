//
//  APIService.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation
 
class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func searchPhoto(query: String, completion: @escaping (Photo?) -> Void ) {
    
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplashAccessKey)") else { return }
        
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
                let result = try JSONDecoder().decode(Photo.self, from: data!)
                completion(result) // 성공하면 Photo 라는 값을 들고가라
                
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}

