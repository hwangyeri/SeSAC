//
//  ViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        
    }
    

    func callRequest() {
        // key에 대한 관리, 매우 중요
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=20120101"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let name = json["boxOfficeResult"]["dailyBoxOfficeList"][0]
                print(name, "---------")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

