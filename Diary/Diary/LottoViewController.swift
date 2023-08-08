//
//  LottoViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var bonusNumLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1100).reversed()//Array(repeating: 100, count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1")
        print("2")
        callRequest(number: 1079)
        
        print("4")
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor  = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        print("5")
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Select \(row)")
        numberTextField.text = "\(list[row])"
        callRequest(number: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                print("3")
                
                let date = json["drwNoDate"].stringValue
                let bonusNumder = json["bnusNo"].intValue
                
                self.bonusNumLabel.text = "\(bonusNumder)"
                self.dateLabel.text = date
                
                print(date, bonusNumder)
            case .failure(let error): // ex. 사이트 점검
                print(error)
            }
        }
    }

}
