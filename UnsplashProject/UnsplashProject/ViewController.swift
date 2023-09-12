//
//  ViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var nicknameTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let value = NSLocalizedString("nickname_result", comment: "")
//        resultLabel.text = String(format: value, "고래밥", "다마고치", "콩닥핑")
        
        nicknameTextField.placeholder = "nickname_placeholder".localized
        resultLabel.text = "age_result".localized(number: 55)
        
        let bar = UISearchBar() //Cmd + Contrl + E : 특정 스코트 내에 반복되는 사항을 처리할때 사용, 각주 처리는 반영안됨
        bar.text = "Aadsa"
        bar.placeholder = "sdds"
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function) //Ctrl + Shift + 클릭
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function) //Ctrl + Shift + 클릭
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function) //Ctrl + Shift + 클릭
    }


}

