//
//  Observable.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

class Observable<T> { // 다른 화면에서 불러서 쉽게 사용 가능
    // 어떤 타입이든 받기위해서 제너릭 타입으로 변경
    
    //var value = "cookie" // 프로퍼티, 선언과 동시에 초기화
    
//    private var listener: (String) -> Void = { nickname in
//        print(nickname) // 얼럿, 변경된 닉네임 레이블..화면전환...
//    } // 필요없어짐 주석처리 후 옵셔널로 변경
    
    private var listener: ((T) -> Void)?
    
    var value: T { // 선언만 해주면 init 구문이 필요함
        didSet {
            //print("didset", value) // didset 으로 신호받기
            listener?(value)
        }
    }
    
    init(_ value: T) { // _ 외부 매개변수 사용 Observable(value: 10) -> Observable(10)
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        print(#function)
        closure(value) // closure 구문을 실행을 해라
        listener = closure // listener 프로퍼티에 외부에서 온 값을 넣어준 것
    }
    
    
}
