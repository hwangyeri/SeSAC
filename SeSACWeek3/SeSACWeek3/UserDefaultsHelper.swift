//
//  UserDefaultsHelper.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/11.
//

import Foundation

class UserDefaultsHelper {  //PropertyWrapper
    
    static let standard = UserDefaultsHelper() //싱글턴 패턴
    // 타입 프로퍼티
    // 여러 인스턴스를 생성할 필요없이 한군데에서만 저장해서 사용할 수있음
    // 클래스의 인스턴스를 만들때마다 공간을 차지하기때문에 데이터에서만 저장을 해주면 효율적으로 관리 가능, 싱글턴 패턴
    // 초기화할 필요없다. 초기화가 한번만 일어난다.
    
    private init() { } //접근 제어자(다음주)
    // 외부에서 초기화를 못하게 접근 제어
    
    let userDefaults = UserDefaults.standard
    
    enum key: String { //컴파일 최적화 // 내가 살 수 있는 공간을 한정적으로 만들어서 빌드할때 ..? 줄어든다
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: key.age.rawValue)
        }
    }
    
}
