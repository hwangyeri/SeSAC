//
//  ShoppingListViewController.swift
//  Setting
//
//  Created by Yeri Hwang on 2023/11/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ShoppingListViewController: UIViewController {
    
//    var shoppingList: [ShoppingListItem] = [
//       ShoppingListItem(isChecked: false, content: "폰 케이스 구매하기", isLiked: true),
//       ShoppingListItem(isChecked: true, content: "신발 사기", isLiked: true),
//       ShoppingListItem(isChecked: true, content: "아이패드 케이스 찾아보기", isLiked: false)
//    ]
//    
//    lazy var shoppingListObservable = BehaviorSubject(value: shoppingList)
    
    private let mainView = ShoppingListView()

    private let viewModel = ShoppingListViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        bind()
    }
    
    func bind() { // Input/Output으로 MVVM 패턴 적용
        
        let shoppingListText = BehaviorRelay<[ShoppingListItem]>(value: [])
        // 뷰모델에 보내줄 데이터
        let input = ShoppingListViewModel.Input(shoppingListText: shoppingListText, textFieldText: mainView.textField.rx.text.orEmpty, addButtonTap: mainView.addButton.rx.tap)
        
        // 뷰모델에서 받아온 데이터
        let output = viewModel.transform(input: input)
        
        // MARK: - cellForRowAt
        output.shoppingListItem
            .bind(to: mainView.tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.identifier, cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
                let index = row
                cell.contentLabel.text = element.content
                cell.checkboxButton.isSelected = element.isChecked
                cell.starButton.isSelected = element.isLiked
                
                //체크박스(완료 기능)
                cell.checkboxButton.rx.tap
                    .map { !element.isChecked }
                    .bind(with: self, onNext: { owner, isSelected in
                        print("checkbox button tapped", isSelected)
                        owner.viewModel.shoppingList[index].isChecked = isSelected
                        output.shoppingListItem.accept(owner.viewModel.shoppingList)
                        print(owner.viewModel.shoppingList)
                    })
                    .disposed(by: cell.disposeBag)
                
                //즐겨찾기
                cell.starButton.rx.tap
                    .map { !element.isLiked }
                    .bind(with: self, onNext: { owner, isSelected in
                        print("star button tapped", isSelected)
                        owner.viewModel.shoppingList[index].isLiked = isSelected
                        output.shoppingListItem.accept(owner.viewModel.shoppingList)
                        print(owner.viewModel.shoppingList)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // MARK: - didSelectRowAt
        mainView.tableView.rx.itemSelected
            //다음 페이지로 화면 전환
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, indexPath in
                print("itemSelected:", indexPath)
                let selectedItem = owner.viewModel.shoppingList[indexPath.row]
                let detailVC = DetailViewController()
                detailVC.selectedItem = selectedItem
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        //삭제
        mainView.tableView.rx.itemDeleted
            .bind(with: self) { owner, indexPath in
                owner.viewModel.shoppingList.remove(at: indexPath.row)
                output.shoppingListItem.accept(owner.viewModel.shoppingList)
            }
            .disposed(by: disposeBag)
        
        //쇼핑리스트 아이템 추가 시, TextField Text 초기화
        output.newItemAdded
            .bind(with: self) { owner, _ in
                owner.mainView.textField.text = ""
            }
            .disposed(by: disposeBag)
    }
    
//    func beforeBind() { // RxSwift
//        // MARK: - cellForRowAt
//        shoppingListObservable
//            .bind(to: mainView.tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.identifier, cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
//                let index = row
//                cell.contentLabel.text = element.content
//                cell.checkboxButton.isSelected = element.isChecked
//                cell.starButton.isSelected = element.isLiked
//                
//                //체크박스(완료 기능)
//                cell.checkboxButton.rx.tap
//                    .map { !element.isChecked }
//                    .subscribe(with: self) { owner, isSelected in
//                        print("checkbox button tapped", isSelected)
//                        owner.shoppingList[index].isChecked = isSelected
//                        owner.shoppingListObservable.onNext(owner.shoppingList)
//                        print(self.shoppingList)
//                    }
//                    .disposed(by: cell.disposeBag)
//                
//                //즐겨찾기
//                cell.starButton.rx.tap
//                    .map { !element.isLiked }
//                    .subscribe(with: self) { owner, isSelected in
//                        print("star button tapped", isSelected)
//                        owner.shoppingList[index].isLiked = isSelected
//                        owner.shoppingListObservable.onNext(owner.shoppingList)
//                        print(self.shoppingList)
//                    }
//                    .disposed(by: cell.disposeBag)
//            }
//            .disposed(by: disposeBag)
//          
//        // MARK: - didSelectRowAt
//        mainView.tableView.rx.itemSelected
//            //다음 페이지로 화면 전환
//            .observe(on: MainScheduler.instance)
//            .subscribe(with: self) { owner, indexPath in
//                print("itemSelected:", indexPath)
//                let selectedItem = owner.shoppingList[indexPath.row]
//                let detailVC = DetailViewController()
//                detailVC.selectedItem = selectedItem
//                owner.navigationController?.pushViewController(detailVC, animated: true)
//            }
//            .disposed(by: disposeBag)
//        
//        
//        //삭제
//        mainView.tableView.rx.itemDeleted
//            .bind(with: self) { owner, indexPath in
//                owner.shoppingList.remove(at: indexPath.row)
//                owner.shoppingListObservable.onNext(owner.shoppingList)
//            }
//            .disposed(by: disposeBag)
//        
//        // MARK: - TextField
//        mainView.textField.rx.text.orEmpty
//            //실시간 검색
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .observe(on: MainScheduler.instance)
//            .subscribe(with: self) { owner, text in
//                let result = text == "" ? owner.shoppingList : owner.shoppingList.filter { $0.content.contains(text) }
//                owner.shoppingListObservable.onNext(result)
//                print("실시간 검색: \(text)")
//            }
//            .disposed(by: disposeBag)
//        
//        //추가
//        mainView.addButton.rx.tap
//            .observe(on: MainScheduler.instance)
//            .subscribe(with: self) { owner, _ in
//                guard let text = owner.mainView.textField.text, !text.isEmpty else { return }
//                let newItem = ShoppingListItem(isChecked: false, content: text, isLiked: false)
//                owner.shoppingList.insert(newItem, at: 0)
//                owner.shoppingListObservable.onNext(owner.shoppingList)
//                owner.mainView.textField.text = ""
//            }
//            .disposed(by: disposeBag)
//
//    }

}
