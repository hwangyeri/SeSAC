//
//  VideoViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class VideoViewController: UIViewController {
    
    var videoList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
    }
    

    func callRequest() {
        let text = "루퐁이네".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! // 옵셔널 바인딩 필요
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)" // 한글에 대한 처리를 해야함
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakaoKey)"] // headers 노출이 조금 더 안전한 편
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["documents"].arrayValue {
                    let title = item["title"].stringValue
                    self.videoList.append(title)
                }
                
                print(self.videoList)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}
