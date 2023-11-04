//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/02.
//

import Foundation
import RxSwift

class PhoneViewModel {
    
    let phone = BehaviorSubject(value: "010")
    let buttonEnabled = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    init() {
        
        phone
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                let value = value.formated(by: "###-####-####")
                owner.phone.onNext(value)
            }
            .disposed(by: disposeBag)
        
        phone
            .map{ $0.count > 10 }
            .bind(to: buttonEnabled)
            .disposed(by: disposeBag)
    }
    
}
