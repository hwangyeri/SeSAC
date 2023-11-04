//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/02.
//

import Foundation
import RxSwift

class BirthdayViewModel {
    
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let buttonEnabled = BehaviorSubject(value: false)
    
    let year = BehaviorSubject(value: 2023)
    let month = BehaviorSubject(value: 11)
    let day = BehaviorSubject(value: 1)
    
    let disposeBag = DisposeBag()
    
    init() {
        
        birthday
            .subscribe(with: self) { owner, date in
                let currentDate = Calendar.current.dateComponents([.year], from: date, to: Date())
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                if let currentYear = currentDate.year, currentYear < 17 {
                    owner.buttonEnabled.onNext(false)
                } else {
                    owner.buttonEnabled.onNext(true)
                }
                owner.year.onNext(component.year!)
                owner.month.onNext(component.month!)
                owner.day.onNext(component.day!)
            } onDisposed: { owner in
                print("birthday dispose")
            }
            .disposed(by: disposeBag)
    }
    
}
