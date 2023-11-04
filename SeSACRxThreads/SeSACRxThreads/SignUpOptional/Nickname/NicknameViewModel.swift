//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/02.
//

import Foundation
import RxSwift

class NicknameViewModel {
    
    let nickname = BehaviorSubject(value: "")
    let buttonHidden = BehaviorSubject(value: true)
    let disposeBag = DisposeBag()
    
    init() {
        
        nickname
            .observe(on: MainScheduler.instance)
            .map { 1 < $0.count && $0.count < 7 }
            .subscribe(with: self) { owner, value in
                self.buttonHidden.onNext(!value)
            }
            .disposed(by: disposeBag)
        
    }

    
}
