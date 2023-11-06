//
//  ShoppingListViewModel.swift
//  Setting
//
//  Created by Yeri Hwang on 2023/11/06.
//

import Foundation
import RxSwift


struct ShoppingListItem {
    var isChecked: Bool
    var content: String
    var isLiked: Bool
}

class ShoppingListViewModel {
    
    let shoppingListSubject: BehaviorSubject<[ShoppingListItem]>
    
    init() {
        
        let shoppingList: [ShoppingListItem] = [
            ShoppingListItem(isChecked: false, content: "폰 케이스 구매하기", isLiked: true),
            ShoppingListItem(isChecked: true, content: "신발 사기", isLiked: true),
            ShoppingListItem(isChecked: true, content: "아이패드 케이스 찾아보기", isLiked: false)
        ]
        
        shoppingListSubject = BehaviorSubject(value: shoppingList)

    }
    
}
