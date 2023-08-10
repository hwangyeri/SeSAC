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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "39IMqNN5k5l35phNJonO",
            "X-Naver-Client-Secret": "\(APIKey.naverKey)"
        ]
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": originalTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
