//
//  MainViewController.swift
//  Emotion
//
//  Created by 황예리 on 2023/07/25.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var pulldownButton: [UIButton]!
    @IBOutlet var emotionButton: [UIButton]!
    @IBOutlet var resetButton: UIButton!
    
    let EmtionImageList = EmtionImageName.allCases
    let PulldownButtonTitleList = PulldownButtonTitle.allCases
    
    //CustomColorArray
    let EmtionColorList = [
        UIColor.customRed,
        UIColor.customOrange,
        UIColor.customYellow,
        UIColor.customMint,
        UIColor.customIndigo
    ]
    
    var result1Value = 0
    var result2Value = 0
    var result3Value = 0
    var result4Value = 0
    var result5Value = 0
    
    enum resultValues: Int, CaseIterable {
        case result1Value
        case result2Value
        case result3Value
        case result4Value
        case result5Value
    }
    
    let resultValueList = resultValues.allCases
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyEmotionButtonImage()
        applyEmotionButtonColor()
        applyEmotionButtonColor()
        emotionButtonStyle()
        pulldownButtonStyle()
        resetButtonStyle()    }
    
    //ButtonImage
    func applyEmotionButtonImage() {
        for (index, emotionButton) in emotionButton.enumerated() {
            guard let emotionImage = EmtionImageName(rawValue: "emoji\(index + 1)") else {
                continue
            }
            emotionButton.setImage(UIImage(named: emotionImage.rawValue), for: .normal)
        }
    }
    
    //ButtonColor
    func applyEmotionButtonColor() {
        for (index, button) in emotionButton.enumerated() {
            button.backgroundColor = EmtionColorList[index]
        }
    }
    
    //ButtonStyle
    func emotionButtonStyle() {
        for item in emotionButton {
            item.setTitle("", for: .normal)
            item.contentMode = .center
        }
    }
    
    func resetButtonStyle() {
        resetButton.setImage(UIImage(systemName: "gobackward"), for: .normal)
        resetButton.setTitle("", for: .normal)
        resetButton.backgroundColor = .white
        resetButton.tintColor = .black
        resetButton.layer.cornerRadius = 12
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 2
    }
    
    func pulldownButtonStyle() {
        for item in pulldownButton {
            item.backgroundColor = .white
            item.tintColor = .black
            item.layer.cornerRadius = 12
            item.layer.borderColor = UIColor.black.cgColor
            item.layer.borderWidth = 2
            item.titleLabel?.textAlignment = .center
            item.setImage(UIImage(systemName: "plus"), for: .normal)
            
            //FIXME: - ButtonTitle Font Size
            item.titleLabel?.font = .boldSystemFont(ofSize: 20)
        }
        
        //ButtonTitle
        for (index, button) in pulldownButton.enumerated() {
            button.setTitle(PulldownButtonTitleList[index].rawValue, for: .normal)
        }
    }
    
    
    //Action
    @IBAction func tappedEmotionButton(_ sender: UIButton) {
        if sender == emotionButton[0] {
            result1Value += 1
            print("result1Value:", result1Value)
        } else if sender == emotionButton[1] {
            result2Value += 1
            print("result2Value:", result2Value)
        } else if sender == emotionButton[2] {
            result3Value += 1
            print("result3Value:", result3Value)
        } else if sender == emotionButton[3] {
            result4Value += 1
            print("result4Value:", result4Value)
        } else if sender == emotionButton[4] {
            result5Value += 1
            print("result5Value:", result5Value)
        }
    }
    
    @IBAction func tappedPulldownButton(_ sender: UIButton) {
        if sender == pulldownButton[0] {
            result1Value += 1
            result2Value += 1
            result3Value += 1
            result4Value += 1
            result5Value += 1
        } else if sender == pulldownButton[1] {
            result1Value += 5
            result2Value += 5
            result3Value += 5
            result4Value += 5
            result5Value += 5
        } else if sender == pulldownButton[2] {
            result1Value += 10
            result2Value += 10
            result3Value += 10
            result4Value += 10
            result5Value += 10
        }
        
        print("result1Value:", result1Value)
        print("result2Value:", result2Value)
        print("result3Value:", result3Value)
        print("result4Value:", result4Value)
        print("result5Value:", result5Value)
    }
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        result1Value = 0
        result2Value = 0
        result3Value = 0
        result4Value = 0
        result5Value = 0
        
        print("result1Value:", result1Value)
        print("result2Value:", result2Value)
        print("result3Value:", result3Value)
        print("result4Value:", result4Value)
        print("result5Value:", result5Value)
    }
    
    
}
