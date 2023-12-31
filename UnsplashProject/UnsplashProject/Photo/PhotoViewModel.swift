//
//  PhotoViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

// ViewModel 에는 import UIKit xx
// 모든 데이터는 ViewModel 에서 가져오기

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: [])) // 제네릭 타입이라 Photo 구조체 그 자체도 들어갈 수 있음
    
    func fetchPhoto(text: String) {
        // ex. <b>, 5,000 처리 => ViewModel 이나 Extension
        // 모든 화면에서 numberFormatter 가 필요하다면 Extension
        // 한 두개 쓰인다면 ViewModel 에서 구현
        
        // 네트워크 통신도 비즈니스 로직으로 볼 수 있음, 연산하는 하나의 과정
        APIService.shared.searchPhoto(query: text) { photo in
            
            DispatchQueue.main.async {
                guard let photo = photo else {
                    return
                }
                self.list.value = photo
            }
        }
    }
    
    func downloadImage(at indexPath: IndexPath, completion: @escaping (Data?) -> Void) {
        let thumb = cellForRowAt(at: indexPath).urls.thumb
        let url = URL(string: thumb)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let imageData = data {
                DispatchQueue.main.async {
                    completion(imageData)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    var rowCount: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results[indexPath.row]
    }
    
    
}
