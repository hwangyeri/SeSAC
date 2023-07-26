//
//  DateViewController.swift
//  Neologism
//
//  Created by 황예리 on 2023/07/20.
//

import UIKit


class AnniversaryCalcViewController: UIViewController {
    /*
     @IBOutlet var background100ImageView: UIImageView! 가 아닌 UIImageView? 일때
         1. 조건문
             if background100ImageView != nil {
             background100ImageView!.layer.cornerRadius = 20
             }
         2. ? 옵셔널 달기
            background100ImageView?.layer.cornerRadius = 20
     */

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var background100ImageView: UIImageView!
    @IBOutlet var background200ImageView: UIImageView!
    @IBOutlet var background300ImageView: UIImageView!
    @IBOutlet var background400ImageView: UIImageView!
    @IBOutlet var background500ImageView: UIImageView!
    @IBOutlet var background600ImageView: UIImageView!
    
    @IBOutlet var date100Lable: UILabel!
    @IBOutlet var date200Lable: UILabel!
    @IBOutlet var date300Lable: UILabel!
    @IBOutlet var date400Lable: UILabel!
    @IBOutlet var date500Lable: UILabel!
    @IBOutlet var date600Lable: UILabel!
    
    @IBOutlet var dDay100Lable: UILabel!
    @IBOutlet var dDay200Lable: UILabel!
    @IBOutlet var dDay300Lable: UILabel!
    @IBOutlet var dDay400Lable: UILabel!
    @IBOutlet var dDay500Lable: UILabel!
    @IBOutlet var dDay600Lable: UILabel!
    
    @IBOutlet var shadow100View: UIView!
    @IBOutlet var shadow200View: UIView!
    @IBOutlet var shadow300View: UIView!
    @IBOutlet var shadow400View: UIView!
    @IBOutlet var shadow500View: UIView!
    @IBOutlet var shadow600View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePickerStyle()
        chagedDatePickerValue(datePicker) // 클릭하지않아도 액션실행
        
        applyImageViewStyle()
        applyLableStyle()
        applyShadowStyle()
        applydDayLableStyle()
        
    }
    
    func datePickerStyle() {
        
        if #available(iOS 14.0, *) { // version 대응
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.tintColor = .red
        datePicker.datePickerMode = .date
    }
    
    func imageViewStyle(name: UIImageView) {
        let anniImage = ["doughnut", "icecream", "churros", "cake", "macaroon"]
        let randomImage = anniImage.randomElement()!
        name.backgroundColor = .white
        name.image = UIImage(named: randomImage)
        name.contentMode = .scaleToFill
        name.layer.cornerRadius = 15
        name.clipsToBounds = true
        // Clips to Bounds, inspector 체크 필요
        // 바깥 테두리를 자를지 말지 선택해야함
    }
    
    func applyImageViewStyle() {
        let allImageView = [background100ImageView, background200ImageView, background300ImageView, background400ImageView, background500ImageView, background600ImageView]
        
        for index in allImageView {
            imageViewStyle(name: index!)
        }
    }
    
    func lableStyle(name: UILabel) {
        name.backgroundColor = .none
        name.text = .none
        name.font = .boldSystemFont(ofSize: 15)
        name.textColor = .white
        name.textAlignment = .center
    }
    
    func applyLableStyle() {
        let allDateLable = [date100Lable, date200Lable, date300Lable, date400Lable, date500Lable, date600Lable]
        
        for index in allDateLable {
            lableStyle(name: index!)
        }
    }
    
    //Shadow
    func shadowStyle(shadowView: UIView) {
        //        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOffset = .zero // 햇빛의 비치는 방향
        shadowView.layer.shadowRadius = 10 // 퍼짐의 정도
        shadowView.layer.shadowOpacity = 0.5 // 불투명도
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.cornerRadius = 15
    }

    func applyShadowStyle() {
        let allShadowView = [shadow100View, shadow200View, shadow300View, shadow400View, shadow500View, shadow600View]
        
        for index in allShadowView {
            shadowStyle(shadowView: index!)
        }
    }
    
    func dDayLableStyle(lable: UILabel, dDayNumber: String) {
        lable.textColor = .white
        lable.textAlignment = .left
        lable.numberOfLines = 1
        lable.font = .italicSystemFont(ofSize: 20)
        lable.text = "D + \(dDayNumber)"
    }
    
    func applydDayLableStyle() {
        let dDayLableDict: [UILabel : String] = [
            dDay100Lable : "100",
            dDay200Lable : "200",
            dDay300Lable : "300",
            dDay400Lable : "400",
            dDay500Lable : "500",
            dDay600Lable : "600"
        ]
        
        for (key, value) in dDayLableDict {
            dDayLableStyle(lable: key, dDayNumber: value)
        }
    }
    
    @IBAction func chagedDatePickerValue(_ sender: UIDatePicker) { // 날짜 선택
        
        print(datePicker.date) // == sender.date
        // 시간은 영국표준시 기준, GMT
        // yyyy - MM - dd hh:mm:ss
        // DatePicker 시간 설정 및 관리, 중요
        
        // 날짜 계산
        // 1. timeinternal (second), ex.86400 * 100
        // 2. Calendar 캘린더 구조체
        let result100 = Calendar.current.date(byAdding: .day, value: 100, to: sender.date) // +100일 뒤
        let result200 = Calendar.current.date(byAdding: .day, value: 200, to: sender.date) // +200일 뒤
        let result300 = Calendar.current.date(byAdding: .day, value: 300, to: sender.date) // +300일 뒤
        let result400 = Calendar.current.date(byAdding: .day, value: 400, to: sender.date) // +400일 뒤
        let result500 = Calendar.current.date(byAdding: .day, value: 500, to: sender.date) // +500일 뒤
        let result600 = Calendar.current.date(byAdding: .day, value: 600, to: sender.date) // +600일 뒤
        
        //DateFormatter: 1. 시간대 변경 2. 날짜 포맷 변경
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일, yyyy년"
        
        let value100 = dateFormat.string(from: result100!)
        let value200 = dateFormat.string(from: result200!)
        let value300 = dateFormat.string(from: result300!)
        let value400 = dateFormat.string(from: result400!)
        let value500 = dateFormat.string(from: result500!)
        let value600 = dateFormat.string(from: result600!)
        
        date100Lable.text = value100
        date200Lable.text = value200
        date300Lable.text = value300
        date400Lable.text = value400
        date500Lable.text = value500
        date600Lable.text = value600
        
        /*
         1. 날짜 선택 - DatePicker
         2. 날짜 계산 - Calendar
         3. 예쁘게 포맷 - DateFormatter
         4. 날짜 보여주기 - UILable
         */
        
    }
    
}

