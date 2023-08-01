//
//  DetailViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    //Pass Data
    //1. 데이터를 받을 공간(프포퍼티) 생성
    var contents: String = "빈 공간"
    
    
    @IBOutlet var contentsLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        
        //Pass Data
        //3. 전달 받은 값을 뷰에 표현
        print(contents)
        contentsLable.text = contents
        contentsLable.textColor = .black
        contentsLable.numberOfLines = 0
    }
    

    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        //navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>) // 원하는 view로 pop
        
    }
    

}
