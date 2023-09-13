//
//  CalculateViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/13.
//

import Foundation

class CalculateViewModel {
    
    var firstNumber: CustomObservable<String?> = CustomObservable("10") // 형변환해서 넘겨주기
    // CustomObservable<String>?> : nil 값도 가질 수 있는 타입으로 변환
    
    var secondNumber: CustomObservable<String?> = CustomObservable("20")
    
    var resultText: CustomObservable<String?> = CustomObservable("결과는 30 입니다.")
    
    var tempText = CustomObservable("테스트를 위한 텍스트임!")
    
    // 어디에 해줄지 바인딩만 해주면 됨 (어떤 기능을 넣어줄지)
    
    func format(for number: Int) -> String { // 로또에서 오는 당첨금액이 크기때문에 , 찍어주기
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func presentNumberFormat() {
        guard let first = firstNumber.value, let firstConvertNumber = Int(first) else {
            tempText.value = "숫자로 변환할 수 없는 문자입니다."
            return
        }
        
        tempText.value = format(for: firstConvertNumber)
    }
    
    func calculate() { // 결과 계산(연산)을 해서 resultText 변경해주기
        
        guard let first = firstNumber.value, let firstConvert = Int(first) else {
            // 옵셔널 바인딩 구문 : nil 이 아닌지 체크, 숫자로 형변환 했을때 잘 들어오는지 확인
            resultText.value = "첫번째 값에서 오류가 발생했어요." // 예외처리 시, 보여주는 문자열도 뷰모델에서 처리
            return
        }
        
        guard let second = secondNumber.value, let secondConvert = Int(second) else {
            resultText.value = "두번째 값에서 오류가 발생했어요."
            return
        }
        
        resultText.value = "결과는 \(firstConvert + secondConvert)입니다."
        
    }
    
}
