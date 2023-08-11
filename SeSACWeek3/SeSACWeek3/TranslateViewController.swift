//
//  TranslateViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var requestButton: UIButton!
    
    //let helper = UserDefaultsHelper() // 초기화 제어를 걸어놔서 초기화 불가능
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalTextView.text = UserDefaultsHelper.standard.nickname
        
        UserDefaults.standard.set("cookie", forKey: "nickname") // UserDefaults에서 값을 저장
        UserDefaultsHelper.standard.nickname = "쿠키"

        UserDefaultsHelper.standard.nickname
        
        
//        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        TranslateAPIManager.shared.callRequest(text: originalTextView.text ?? "") {result in
            self.translateTextView.text = result
        }
    }
    
    
}
