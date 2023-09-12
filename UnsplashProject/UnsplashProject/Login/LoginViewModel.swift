//
//  LoginViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    // 모든 연산과 데이터는 뷰모델이 담당
    
    var id = Observable("")
    var pw = Observable("")
    var isValid = Observable(false) // 로그인을 시켜줘도 되는지 관리
    
    func checkValidation() {
        if id.value.count >= 6 && pw.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        
        //서버, 닉네임, id => UserDefaults 저장하는 로직도 뷰모델에 구현
        UserDefaults.standard.set(id.value, forKey: "id")
        
        // 비즈니스 로직 처리는 다 했는데 화면전환 해야할 때, completionHandler
        completion()
        
    }
    
    
}
