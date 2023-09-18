//
//  JoinViewModel.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

class JoinViewModel {
    
    var email: Observable<String?> = Observable("")
    var password: Observable<String?> = Observable("")
    var nickname: Observable<String?> = Observable("")
    var location: Observable<String?> = Observable("")
    var recommendCode: Observable<String?> = Observable("")
    var isValid = Observable(false) // 회원가입 시켜줘도 되는지 관리
    var result = Observable("")
    
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
        
        guard let text = email.value else {
            result.value = "⚠️ 이메일을 입력해주세요, example@example.com"
            isValid.value = false
            return
        }
        
        guard text.contains("@") else {
            result.value = "⚠️ 이메일에 @가 빠졌습니다."
            isValid.value = false
            return
        }
        
        guard text.count > 4 else {
            result.value = "⚠️ 이메일은 최소 5자리 이상 입니다."
            isValid.value = false
            return
        }
        
        guard let pwText = password.value else {
            result.value = "⚠️ 비밀번호를 입력해주세요."
            isValid.value = false
            return
        }
        
        guard pwText.count > 5, pwText.count < 11 else {
            result.value = "⚠️ 비밀번호는 6~10자리로 입력해주세요."
            isValid.value = false
            return
        }
        
        guard let nicknameText = nickname.value else {
            result.value = "⚠️ 닉네임을 입력해주세요."
            isValid.value = false
            return
        }
        
        guard nicknameText.count > 0, nicknameText.count < 13 else {
            result.value = "⚠️ 닉네임은 12자리 이내로 입력해주세요."
            isValid.value = false
            return
        }
        
        guard let locationText = location.value else {
            result.value = "⚠️ 위치를 입력해주세요."
            isValid.value = false
            return
        }
        
        guard locationText.count > 1 else {
            result.value = "⚠️ 위치는 1글자 이상 입력해주세요."
            isValid.value = false
            return
        }
        
        guard let code = recommendCode.value else {
            result.value = "⚠️ 추천 코드는 숫자 6자리입니다."
            isValid.value = false
            return
        }
        
        guard let codeToNumber = Int(code), code.count == 6 else {
            result.value = "⚠️ 추천 코드는 6자리 숫자입니다."
            isValid.value = false
            return
        }
        
        result.value = "✅ 회원가입 버튼을 눌러주세요."
        isValid.value = true
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
