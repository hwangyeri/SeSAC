//
//  WeatherViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {

    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
    }
    

    func callRequest() {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.weatherKey)"
        
        // validate 상태 처리에 대한 예외처리
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 283.15 // 절대온도 -> 섭씨온도로 바꾸기
                let humiddity = json["main"]["humiddity"].intValue
                
                let id = json["weather"][0]["id"].intValue //803
                
                switch id {
                case 800: print("매우 맑음")
                case 801...899:
                    self.weatherLabel.text = "구름이 낀 날씨입니다"
                    self.view.backgroundColor = .systemGray6
                default: print("나머지는 생략...!!")
                }
                
                self.tempLabel.text = "\(temp)도 입니다"
                self.humidityLabel.text = "\(humiddity)% 입니다"
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
