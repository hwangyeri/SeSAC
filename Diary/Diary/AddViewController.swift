//
//  AddViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

// 230803
enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

//1. UITextViewDelegate
//2. contentTextView.delegate = self
//3. 필요한 메서드 호출해서 구현
class AddViewController: UIViewController, UITextViewDelegate { // 1.Delegate 부하직원 불러오기
    
    var type: TransitionType = .add
    
    //var contents: String = "" //1.선언과 동시에 초기화, 의미없는 빈 문자열을 쓰는건 좋지않음
    var contents: String? //2.옵셔널 핸드링 필요
    
    static let identifier = "AddViewController"

    @IBOutlet var contentTextView: UITextView!
    
    //placeholder
    let placeholderText = "내용을 입력해주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self // 2.부하직원 연결
        
        setBackgroundColor()
        
        //추가 화면 일 때는 빈 텍스트 뷰를, 수정 화면 일 때는 이전 내용을 값 전달 해서 텍스트 뷰에 보여주기
        switch type {
        
        case .add:
            title = type.rawValue // navigation title
            
            //LeftBarButton
            let xmark = UIImage(systemName: "xmark")
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
            
            navigationItem.leftBarButtonItem?.tintColor = .red
            //contentTextView.text = contents
            contentTextView.text = placeholderText
            contentTextView.textColor = .lightGray
            
        case .edit: //print("")
            title = type.rawValue // navigation title
            
            guard let contents else { return }
            contentTextView.text = contents
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) { // 글자가 바뀔때마다 호출 - 글자수 체크
        print(textView.text.count)
        title = "\(textView.text.count)글자"
    }
    
    //편집이 시작될 때(커서가 시작될 때)
    //플레이스 홀더와 텍스트뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
    @objc
    func closeButtonClicked() {
        
        //Present - Dismiss
        dismiss(animated: true)
        
        //Push - pop, 짝꿍을 잘 맞춰야함
        //navigationController?.popViewController(animated: true)
    }
    
    

}
