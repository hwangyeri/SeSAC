//
//  YeriObservable.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/13.
//

import Foundation

class CustomObservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value) // 처음에는 nil 값이라 실행 안됨, introduce 메서드 만난 후 실행, introduce 실행된 이후에는 listener 에 있는 기능이 실행되서 뷰 배경색 변경
            print("사용자의 이름이 \(value)로 변경되었습니다.")
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ sample: @escaping (T) -> Void) {
        print("저는 \(value)입니다.")
        sample(value) // 뷰컨에서 사용자에게 네임 값을 보여주기 위해서
        listener = sample // listener 에 값을 업데이트 해줌
        // listener = sample 가 있어서 실시간으로 배경색 변경도 가능하게 됨
        // 매개변수를 쓰지않으면 어떤 변화도 일어나지않음
    }
    
}

//class Person {
//
//    /*
//
//     프로퍼티에 감시자를 달아서 내용이 바뀌면 사용자가 정상적으로 전환된 이름으로 쓰고있는지 확인하기 위해서 didset 을 이용해서 프린트
//
//     didset 쓰면 데이터가 바뀔때마다 일일히 프린트 안해도 됨
//     => ex. person.name = "카스타드"
//            print("사용자의 이름이 \(name)로 변경되었습니다.")
//            person.name = "칙촉"
//            print("사용자의 이름이 \(name)로 변경되었습니다.")
//
//     */
//
//    var luckyNumber: Int?
//    var listener: (() -> Void)? // 이름이 변경되면 sample 이 가진 기능도 실행하고 싶어
//
//    var name: String {
//        didSet { // 프로퍼티가 바뀔때 마다 감지, 내용이 바뀔때마다 didset 구문 실행
//            listener?()
//            print("사용자의 이름이 \(name)로 변경되었습니다. 당신이 뽑은 행운의 숫자는 \(luckyNumber ?? 0)입니다.") // 처음에는 luckyNumber 에 nil 값이 들어옴
//        }
//    }
//
//    init(_ name: String) { // 외부 매겨변수 생략해서 사용할 수 있게 와일드카드 식별자 붙임
//        self.name = name
//    }
//
//    func introduce(_ number: Int, sample: @escaping () -> Void) {
//        // 메서드에도 와일드카드 식별자 붙임
//        // 매개변수가 1개 들어올때나 너무 객체가 들어올지 명확할때 사용
//        print("저는 \(name)이고, 행운의 숫자는 \(number)입니다.")
//        sample() // 함수의 기능과 함수의 실행을 나눔
//        luckyNumber = number
//        listener = sample
//    }
//
//}
//
// number 매개변수 없앰
