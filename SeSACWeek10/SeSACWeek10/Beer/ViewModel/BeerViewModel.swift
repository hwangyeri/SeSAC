//
//  BeerViewModel.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import Foundation

final class BeerViewModel {
    
    func request(api: BeerRouter, completion: @escaping (Result<Beer, SeSACError>) -> Void ) {
        NetworkBeer.shared.requestConvertible(type: Beer.self, api: api) { response in
            switch response {
            case .success(let success):
                dump(success)
                completion(.success(success))
            case .failure(let failure):
                print(failure.errorDescription)
                completion(.failure(failure))
            }
        }
    }
    
}
