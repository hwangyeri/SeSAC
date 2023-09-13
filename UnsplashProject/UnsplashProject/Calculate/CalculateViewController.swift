//
//  CalculateViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // ViewController 입장에서는 firstNumber - firstTextField 짝궁인 것만 알지, 3이 들어있는지는 모른다
    // 어떤 데이터가 누구랑 매칭되어있는지만 확인 가능
    // ViewController 는 단순히 present 보여주는 역할만 함
    // 어떤 연산이 들어가는지, 어떤 로직이 어떻게 동작하는지 모름
    // 변화들은 bind 에서 처리
    // Rx : 실시간 데이터 바인딩
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Action
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        // Display
        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
            // 값이 바뀔때마다 업데이트 해주세요
            print("firstNumber chaged \(number)")
        }
        
        viewModel.secondNumber.bind { number in // 변경된 데이터를 클로저로 받음
            self.secondTextField.text = number
            print("secondNumber chaged \(number)")
        }
        
        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        
        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
        
    }
    
    @objc func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calculate()
        viewModel.presentNumberFormat()
    }
    
    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()
    }

}

//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    let person = CustomObservable("새싹이")
//
//    person.value = "카스타드"
//    person.value = "칙촉"
//
////        person.introduce(Int.random(in: 1...10)) {
////            self.view.backgroundColor = [UIColor.orange, UIColor.magenta, UIColor.yellow].randomElement()!
////        }
//    person.bind { value in // 사용자에게 바뀐 이름 보여주기
//        self.resultLabel.text = value
//        self.view.backgroundColor = [UIColor.orange, UIColor.magenta, UIColor.yellow].randomElement()!
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 몇초뒤에 실행할지 지연시킬 수 있음, 현재 시간의 n초 뒤에 실행
//        person.value = "바나나"
//        print(" === 1초 뒤 === ")
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        person.value = "키위"
//        print(" === 3초 뒤 === ")
//    }
//
//    firstTextField.text = viewModel.firstNumber.value
//    secondTextFiekd.text = viewModel.secondNumber.value
//}
