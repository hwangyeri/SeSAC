//
//  AutoLayoutExampleViewController.swift
//  Neologism
//
//  Created by 황예리 on 2023/07/21.
//

import UIKit

class AutoLayoutExampleViewController: UIViewController {
    
    @IBOutlet var resultLable: UILabel!
    
    @IBOutlet var exampleTextField: UITextField!
    
    @IBOutlet var keywordButton: [UIButton]!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var backgoroundImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style
        keywordButtonStyle()
        exampleTextFieldStyle()
        resultLableStyle()
        backgroundImageViewStyle()
        searchButtonStlye()
        //        exampleTextField.text = getRandomWord()
        
    }
    
    
    @discardableResult // 반환타입을 무시할 수 있는 함수
    func getRandomWord() -> String {
        let random = ["111", "222", "333"]
        //        let resultWord = exampleTextField.text = random.randomElement()!
        let resultWord = random.randomElement()!
        
        return resultWord
    }
    
    func keywordButtonStyle() {
        //        keyword2Button.isHidden = true // Hidden 속성 적용
        
        for keyword in keywordButton {
            keyword.titleLabel?.font = .systemFont(ofSize: 12)
            keyword.tintColor = .black
            keyword.backgroundColor = .white
            keyword.layer.borderColor = UIColor.black.cgColor
            keyword.layer.borderWidth = 1
            keyword.layer.cornerRadius = 14
            
            //shadow
            keyword.layer.shadowColor = UIColor.darkGray.cgColor
            keyword.layer.shadowOffset = .zero
            keyword.layer.shadowOpacity = 0.2
            keyword.layer.shadowRadius = 14
            
        }
        
    }
    
    func searchButtonStlye() {
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
        searchButton.titleLabel?.text = .none
    }
    
    func exampleTextFieldStyle() {
        exampleTextField.placeholder = "단어의 뜻을 궁금하다면 검색해보세요!"
        exampleTextField.textColor = .black
        exampleTextField.font = .systemFont(ofSize: 16)
        exampleTextField.borderStyle = .line
        exampleTextField.keyboardType = .default
        exampleTextField.layer.borderColor = UIColor.black.cgColor
        exampleTextField.layer.borderWidth = 2
        exampleTextField.layer.backgroundColor = UIColor.white.cgColor
        
        //leadingPadding
        let leadingPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // 원하는 패딩 값 설정
        exampleTextField.leftView = leadingPaddingView
        exampleTextField.leftViewMode = .always
    }
    
    func resultLableStyle() {
        resultLable.text = "모르는 신조어, 유행하는 밈이 있나요?\n검색을 통해 궁금증을 해결해보세요. 😎"
        resultLable.font = .systemFont(ofSize: 16)
        resultLable.textColor = .black
        resultLable.backgroundColor = .none
        resultLable.textAlignment = .center
        resultLable.numberOfLines = 0
        view.addSubview(backgoroundImageView)
    }
    
    func backgroundImageViewStyle() {
        backgoroundImageView.image = UIImage(named: "background")
        backgoroundImageView.contentMode = .scaleAspectFit
        view.addSubview(resultLable)
    }
    
    func
    
    @IBAction func tappedSearchButton(_ sender: UIButton) {
        exampleTextField.text = sender.currentTitle
        
    }
    
    @IBAction func tappedKeywordButton(_ sender: UIButton) {
        //        print(sender.currentTitle)
        //        print(sender.titleLabel?.text)
        
        //2. 버튼 클릭시 텍스트필드의 텍스트에 버튼 타이틀이 들어가는 기능
        exampleTextField.text = sender.currentTitle
        
        //3. 텍필 텍스트를 결과 레이블로 보여주는 기능
        clickedExampleTextField(exampleTextField)
    }
    
    @IBAction func clickedExampleTextField(_ sender: UITextField) {
        //        print("DidEndOnExit - 키보드를 나갔을때")
        
        //        switch exampleTextField.text {
        //            // exampleTextField.text == sender.text
        //            // JMT, jmt 같은 결과를 보여주기 위해서
        //            // 다 소문자로 바꿔서 서치 .lowercased()
        //
        //        case "통모짜핫도그":
        //            resultLable.text = "'나 요즘 통 못 자' 를\n명랑핫도그 통모짜핫도그와\n발음이 비슷해서 쓰는 말"
        //        case "요즘잘자쿨냥이":
        //            resultLable.text = "'통모짜핫도그'의 반댓말\n요즘 잘잔다를 귀엽게 표현한 말"
        //        case "오우예 씨몬":
        //            resultLable.text = "C'mon(커몬)을\n 씨몬으로 발음하면 생기는 일\nMZ 사이에서 감탄사처럼 쓰이는 말"
        //        case "꾸웨엑?":
        //            resultLable.text = "'후회해?'라는 뜻\n후회해? 를 꾸웨엑? 으로\n잘못 알아들으며 생긴 밈"
        //        case "디토합니다":
        //            resultLable.text = "공감의 표현 (= 인정합니다)\n예시) A: 퇴근하고 싶다.. B: 디토합니다."
        //        case "어라랍스터?":
        //            resultLable.text = "요즘 애들의 감탄사\n예시) 어라랍스터? 이런 게 있었나??"
        //        case "추구미":
        //            resultLable.text = "'내가 원하는 이미지'라는 뜻\n예시) 와, 이 스타일 완전 내 추구미 🫢"
        //        default:
        //            resultLable.text = "ERROR"
        //            print("Error-\(#file)-\(#function)")
        //        }
        
        let wordData: [String: String] = [
            "통모짜핫도그": "'나 요즘 통 못 자' 를\n명랑핫도그 통모짜핫도그와\n발음이 비슷해서 쓰는 말",
            "요즘잘자쿨냥이": "'통모짜핫도그'의 반댓말\n요즘 잘잔다를 귀엽게 표현한 말",
            "오우예 씨몬": "C'mon(커몬)을\n씨몬으로 발음하면 생기는 일\nMZ 사이에서 감탄사처럼 쓰이는 말",
            "꾸웨엑?": "'후회해?'라는 뜻\n후회해? 를 꾸웨엑? 으로\n잘못 알아들으며 생긴 밈",
            "디토합니다": "공감의 표현 (= 인정합니다)\n예시) A: 퇴근하고 싶다.. B: 디토합니다.",
            "어라랍스터?": "요즘 애들의 감탄사\n예시) 어라랍스터? 이런 게 있었나??"
        ]
        
        for index in wordData {
            if exampleTextField.text == index.key {
                resultLable.text = index.value
            }
        }
        
//        if let inputText = exampleTextField.text {
//            if inputText.isEmpty {
//                resultLable.text = "검색어를 입력해주세요. 😭"
//            } else if inputText.count == 1 {
//                resultLable.text = "한 글자 이상 입력해주세요. 😢"
//            } else if inputText == " " {
//                resultLable.text = "빈칸"
//            }
//        } else {
//            print("Error-\(#file)-\(#function)")
//        }
        
       
        /*
         1. 버튼 만들기
         2. 버튼 클릭시 텍필에 표시 - tappedKeywordButton
         3. 결과 레이블에 보여주기 - clickedExampleTextField
         */
        
    }
    
    @IBAction func tappedTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
