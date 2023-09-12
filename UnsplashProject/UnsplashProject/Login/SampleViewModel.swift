//
//  SampleViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

class SampleViewModel {
    
    var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "KoKojong", age: 20)]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row] // User(name: "Hue", age: 23) 이런 값 하나씩을 의미
    }
    
    
}
