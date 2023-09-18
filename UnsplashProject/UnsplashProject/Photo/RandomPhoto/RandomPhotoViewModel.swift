//
//  RandomPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/18.
//

import Foundation

class RandomPhotoViewModel {
    
    let list: Observable<[RandomPhoto]> = Observable( [ ] )
    
    func remove() {
        list.value = []
    }
    
    func insertPhoto(query: String) {
        let url = RandomPhoto(url: "https://source.unsplash.com/featured/?\(query)&w=300&h=100")
        list.value.insert(url, at: 0)
    }
    
}
