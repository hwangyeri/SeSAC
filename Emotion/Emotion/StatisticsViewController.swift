//
//  StatisticsViewController.swift
//  Emotion
//
//  Created by 황예리 on 2023/07/25.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet var scoreLable: [UILabel]!
    @IBOutlet var emotionTypeLable: [UILabel]!
    
    let emotionTypeTitleLableList = emotionTypeLableTitle.allCases
    
    //CustomColorArray
    let EmtionColorList = [
        UIColor.customRed,
        UIColor.customOrange,
        UIColor.customYellow,
        UIColor.customMint,
        UIColor.customIndigo
    ]
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        applyscoreLableColor()
        applyEmotionTitleLable()
        scoreLableStyle()
        emotionTitleLableStyle()
    }
    

    //LableColor
    func applyscoreLableColor() {
        for (index, lable) in scoreLable.enumerated() {
            if index < EmtionColorList.count {
                lable.backgroundColor = EmtionColorList[index]
            } else {
                lable.backgroundColor = .black
                print("Error-\(#function)")
            }
        }
    }
    
    //LableTitle
    func applyEmotionTitleLable() {
        print(EmtionImageName.완전행복지수, #function)
        for (index, lable) in emotionTypeLable.enumerated() {
            let title = emotionTypeTitleLableList
            lable.text = "\(title[index])"
        }
    }
    
    func applyscoreLableTitle() {
    }
    
    //Style
    func scoreLableStyle() {
        for lable in scoreLable {
            lable.text = "1점"
            lable.textColor = .black
            lable.textAlignment = .right
            lable.font = .systemFont(ofSize: 30)
            lable.layer.cornerRadius = 17
            lable.layer.masksToBounds = true
        }
    }
    
    func emotionTitleLableStyle() {
        for lable in emotionTypeLable {
            lable.font = .systemFont(ofSize: 17)
            lable.textColor = .black
            lable.textAlignment = .left
        }
    }

    
    
}
