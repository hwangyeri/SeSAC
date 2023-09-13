//
//  JoinViewModel.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

class JoinViewModel {
    
    var email = Observable("")
    var password = Observable("")
    var nickname = Observable("")
    var location = Observable("")
    var recommendCode = Observable("")
    var join = Observable("회원가입")
    var isValid = Observable(false) // 로그인을 시켜줘도 되는지 관리
    
//    init() { // 저장된 UserDefaults 값 불러오기
//
//        if let savedEmail = UserDefaults.standard.string(forKey: "email") {
//            email.value = savedEmail
//        }
//
//        if let savedPassword = UserDefaults.standard.string(forKey: "password") {
//            password.value = savedPassword
//        }
//
//        if let savedNickname = UserDefaults.standard.string(forKey: "nickname") {
//            nickname.value = savedNickname
//        }
//
//        if let savedLocation = UserDefaults.standard.string(forKey: "location") {
//            location.value = savedLocation
//        }
//
//        if let savedRecommendCode = UserDefaults.standard.string(forKey: "recommendCode") {
//            recommendCode.value = savedRecommendCode
//        }
//
//        checkValidation()
//    }
    
    func checkValidation() {
        if email.value.count >= 6 && password.value.count >= 4 && nickname.value.count >= 1 && location.value.count >= 1 && recommendCode.value.count >= 1 {
            isValid.value = true
            return join.value = "회원가입 성공!"
        } else {
            isValid.value = false
            return join.value = "회원가입"
        }
    }
    
    func savedUserDefaults(completion: @escaping () -> Void) {
        
        UserDefaults.standard.set(email.value, forKey: "email")
        UserDefaults.standard.set(password.value, forKey: "password")
        UserDefaults.standard.set(nickname.value, forKey: "nickname")
        UserDefaults.standard.set(location.value, forKey: "location")
        UserDefaults.standard.set(recommendCode.value, forKey: "recommendCode")
        
        completion()
    }
    
    
}
