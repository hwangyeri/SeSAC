//
//  SimpleViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/18.
//

import Foundation

// 0918 ViewModel 데이터로 분리

class NewSimpleViewModel {
    
    let list: Observable<[User]> = Observable( [ ] )
    
    var list2 = [
        User(name: "파이리", age: 6),
        User(name: "피카츄", age: 1),
        User(name: "라이츄", age: 2),
        User(name: "꼬부기", age: 28)
    ]
    
    func append() {
        list.value = [
            User(name: "Hue", age: 23),
            User(name: "Hue", age: 23),
            User(name: "Bran", age: 20),
            User(name: "KoKojong", age: 20)]
    }
    
    func remove() {
        list.value = []
    }
    
    func removeUser(idx: Int) {
        list.value.remove(at: idx)
    }
    
    func insertUser(name: String) {
        let user = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(user, at: Int.random(in: 0...2))
    }
    
}
