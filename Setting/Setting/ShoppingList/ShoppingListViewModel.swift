//
//  ShoppingListViewModel.swift
//  Setting
//
//  Created by Yeri Hwang on 2023/11/06.
//

import Foundation
import RxSwift
import RxCocoa

struct ShoppingListItem {
    var isChecked: Bool
    var content: String
    var isLiked: Bool
}

class ShoppingListViewModel: ViewModelType {
    
    struct Input {
        let tableViewItemSelected: ControlEvent<IndexPath> // tableView.rx.itemSelected
        let textFieldText: ControlProperty<String?> // textField.rx.text
        let addButtonTap: ControlEvent<Void> // addButton.rx.tap
    }
    
    struct Output {
        let items: PublishSubject<[ShoppingListItem]>
        let textFieldText: PublishSubject<[ShoppingListItem]>
        let addButtonTap: ControlEvent<Void>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let shoppingList = PublishSubject<[ShoppingListItem]>()
        
        input.textFieldText
            .orEmpty
            //실시간 검색
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
//                let result = text == "" ? owner.shoppingList : owner.shoppingList.filter { $0.content.contains(text) }
//                owner.shoppingListObservable.onNext(result)
//                print("실시간 검색: \(text)")
            }
            .disposed(by: disposeBag)
        
        return Output(
            items: <#PublishSubject<[ShoppingListItem]>#>,
            textFieldText: <#PublishSubject<[ShoppingListItem]>#>,
            addButtonTap: <#ControlEvent<Void>#>
            
        )
    }
    
}
