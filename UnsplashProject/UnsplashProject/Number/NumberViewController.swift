//
//  NumberViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    func bindData() {
        
        viewModel.number.bind { value in
            
            self.numberTextField.text = value
            //self.resultLabel.text = value // 하나의 데이터를 여러 뷰 객체에도 표현할 수 있음
        }
        
        viewModel.result.bind { value in
            self.resultLabel.text = value
        }
    }
    
    @objc func numberTextFieldChanged() {
        
//        //빈 값, 문자열, 백만원 내에서 가능 (한도) // 뷰모델로 분리!
//        guard let text = numberTextField.text else {
//            resultLabel.text = "값을 입력해주세요." // 빈 값, 예외처리
//            return
//        }
//
//        guard let textToNumber = Int(text) else {
//            resultLabel.text = "100만원 이하의 숫자를 입력해주세요." // 문자열, 예외처리
//            return
//        }
//
//        guard textToNumber > 0, textToNumber <= 1000000 else {
//            resultLabel.text = "환전 범주는 100만원 이하입니다." // 한도, 예외처리
//            return
//        }
//
//        let numberForMatter = NumberFormatter()
//        numberForMatter.numberStyle = .decimal
//
//        let decimalNumber = numberForMatter.string(for: textToNumber * 1327)! // 쉼표 처리
//
//        resultLabel.text = "환전 금액은 \(decimalNumber)입니다."
        
        viewModel.number.value = numberTextField.text
        viewModel.convertNumber()
    }


}
