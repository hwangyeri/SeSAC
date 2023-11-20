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
    
    var shoppingList: [ShoppingListItem] = []
    
    struct Input {
        let shoppingListText: BehaviorRelay<[ShoppingListItem]>
        var textFieldText: ControlProperty<String> // textField.rx.text.orEmpty
        let addButtonTap: ControlEvent<Void> // addButton.rx.tap
    }
    
    struct Output {
        let shoppingListItem: BehaviorRelay<[ShoppingListItem]>
        let newItemAdded: Observable<Void>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let shoppingListBehavior = BehaviorRelay(value: shoppingList)
        let newItemAddedSubject = PublishSubject<Void>()
        
        // MARK: - TextField
        input.textFieldText
            //실시간 검색
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                let result = text == "" ? owner.shoppingList : owner.shoppingList.filter { $0.content.contains(text) }
                shoppingListBehavior.accept(result)
                print("실시간 검색: \(text)")
            }
            .disposed(by: disposeBag)
        
        //추가
        input.addButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.textFieldText, resultSelector: { _, query in
                return query
            })
            .bind(with: self) { owner, text in
                let newItem = ShoppingListItem(isChecked: false, content: text, isLiked: false)
                owner.shoppingList.insert(newItem, at: 0)
                shoppingListBehavior.accept(owner.shoppingList)
                newItemAddedSubject.onNext(())
            }
            .disposed(by: disposeBag)
        
        input.shoppingListText
            .bind(with: self) { owner, value in
                owner.shoppingList.append(contentsOf: value)
                shoppingListBehavior.accept(owner.shoppingList)
            }
            .disposed(by: disposeBag)
        
        return Output(
            shoppingListItem: shoppingListBehavior, 
            newItemAdded: newItemAddedSubject.asObservable()
        )
    }
    
}
