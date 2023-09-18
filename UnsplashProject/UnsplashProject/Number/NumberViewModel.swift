//
//  NumberViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/18.
//

import Foundation

class NumberViewModel {
    
    var number: Observable<String?> = Observable("1000") //numberTextField
    var result = Observable("1,327,000") //resultLabel
    
    func convertNumber() {
        
        //빈 값, 문자열, 백만원 내에서 가능 (한도)
        guard let text = number.value else {
            result.value = "값을 입력해주세요." // 빈 값, 예외처리
            return
        }
        
        guard let textToNumber = Int(text) else {
            result.value = "100만원 이하의 숫자를 입력해주세요." // 문자열, 예외처리
            return
        }
        
        guard textToNumber > 0, textToNumber <= 1000000 else {
            result.value = "환전 범주는 100만원 이하입니다." // 한도, 예외처리
            return
        }
        
        let numberForMatter = NumberFormatter()
        numberForMatter.numberStyle = .decimal
        
        let decimalNumber = numberForMatter.string(for: textToNumber * 1327)! // 쉼표 처리
        
        result.value = "환전 금액은 \(decimalNumber)입니다."
        
    }
    
}
