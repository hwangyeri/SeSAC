//
//  ViewModel.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    func request(completion: @escaping (URL) -> Void ) {
        // Convertible protocol 채택
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                dump(success)
                
                //self.imageView.kf.setImage(with: URL(string: success.urls.thumb)!)
                // URL만 다룬다면 URL만 넘겨주겠지만, 다른 값을 같이 넘긴다면 response 로 넘김
                completion(URL(string: success.urls.thumb)!)
                
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
}
