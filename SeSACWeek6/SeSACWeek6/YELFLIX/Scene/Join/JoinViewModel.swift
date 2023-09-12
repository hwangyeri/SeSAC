//
//  JoinViewModel.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

class JoinViewModel {
    
    var email = Observable("")
    var pw = Observable("")
    var nickname = Observable("")
    var location = Observable("")
    var recommendCode = Observable("")
    var isValid = Observable(false) // 로그인을 시켜줘도 되는지 관리
    
    func checkValidation() {
        if email.value.count >= 6 && pw.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        
        UserDefaults.standard.set(email.value, forKey: "email")
        
        completion()
        
    }
    
    
}
