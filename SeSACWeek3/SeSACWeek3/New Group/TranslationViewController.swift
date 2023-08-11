//
//  TranslationViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

//class TranslationViewController: UIViewController {
//
//    @IBOutlet var originalTextView: UITextView!
//    @IBOutlet var translateTextView: UITextView!
//    @IBOutlet var requestButton: UIButton!
//
//    //let helper = UserDefaultsHelper() // 초기화 제어를 걸어놔서 초기화 불가능
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //originalTextView.text = UserDefaults.standard.string(forKey: "nickname") // UserDefaults에서 값을 가져올때
//        //originalTextView.text = helper.nickname
//        originalTextView.text = UserDefaultsHelper.standard.nickname
//
//        //UserDefaults.standard.set("cookie", forKey: "nickname") // UserDefaults에서 값을 저장
//        //helper.nickname = "쿠키"
//        UserDefaultsHelper.standard.nickname = "쿠키"
//
//
//        originalTextView.text = ""
//        translateTextView.text = ""
//        translateTextView.isEditable = false
//    }
//
//    @IBAction func requestButtonClicked(_ sender: UIButton) {
//        let url = "https://openapi.naver.com/v1/papago/detectLangs"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": "39IMqNN5k5l35phNJonO",
//            "X-Naver-Client-Secret": "\(APIKey.naverKey)"
//        ]
//        let parameters: Parameters = [
//            "query": originalTextView.text ?? ""
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                let data = json["langCode"].stringValue
//
//                let papagoUrl = "https://openapi.naver.com/v1/papago/n2mt"
//                let papagoParameters: Parameters = [
//                    "source": data,
//                    "target": "en",
//                    "text": self.originalTextView.text ?? ""
//                ]
//
//                AF.request(papagoUrl, method: .post, parameters: papagoParameters, headers: header).validate().responseJSON { response in
//                    switch response.result {
//                    case .success(let value):
//                        let json = JSON(value)
//                        print("JSON: \(json)")
//
//                        let data = json["message"]["result"]["translatedText"].stringValue
//                        self.translateTextView.text = data
//
//                    case .failure(let error):
//                        print(#function, error)
//                    }
//                }
//
//            case .failure(let error):
//                print(#function, error)
//            }
//        }
//
//
//    }
//
//}
