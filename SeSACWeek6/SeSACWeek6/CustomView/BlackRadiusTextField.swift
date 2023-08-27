//
//  BlackRadiusTextField.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/24.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    //Interface Builder를 사용하지 않고, UIView를 상속 받은 Custom Class를 코드로 구성할 때 사용되는 초기화 구문 // Codebase
    override init(frame: CGRect) { //UIView
        super.init(frame: frame)
        setupView()
    }
    
    //XIB -> NIB 변환 과정에서 객체 생성 시 필요한 init 구문 (storyboard)
    //Interface Builder에서 생성된 뷰들이 초기화될 때 실행되는 구문!
    required init?(coder: NSCoder) { //NSCoding
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        borderStyle = .none
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        textColor = .black
        textAlignment = .center
        font = .boldSystemFont(ofSize: 15)
    }
    
    
}

protocol ExampleProtocol {
    init(name: String)
}

class Mobile: ExampleProtocol {
    
    let name: String
    
    //required: 프로토콜애서 생성된 경우 사용하는 키워드
    //required Initializer
    required init(name: String) {
        self.name = name
        print("Mobile Init")
    }
    
    
}
