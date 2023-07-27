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
    
    let pulldownButtonTitleList = PulldownButtonTitle.allCases
    let emtionImageNameList = EmtionImageName.allCases
    
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
        
        applyEmotionButtonImage()
        applyEmotionButtonColor()
        applyEmotionButtonColor()
        emotionButtonStyle()
        pulldownButtonStyle()
        resetButtonStyle()
        
    }
    
    //ButtonImage
    func applyEmotionButtonImage() {
        for (index, emotionButton) in emotionButton.enumerated() {
            emotionButton.setImage(UIImage(named: emtionImageNameList[index].rawValue), for: .normal)
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
            button.setTitle(pulldownButtonTitleList[index].rawValue, for: .normal)
        }
    }
    
    
    //Action
    @IBAction func tappedEmotionButton(_ sender: UIButton) {
        guard let index = emotionButton.firstIndex(of: sender) else { return }
        let resultKey = ResultValues.allCases[index].rawValue
        let count = UserDefaults.standard.integer(forKey: resultKey)
        UserDefaults.standard.setValue(count + 1, forKey: resultKey)
        print("emotion\(index + 1)Count:", UserDefaults.standard.integer(forKey: resultKey))
    }
    
    @IBAction func tappedPulldownButton(_ sender: UIButton) {
        let value1 = UserDefaults.standard.integer(forKey: ResultValues.result1Value.rawValue)
        let value2 = UserDefaults.standard.integer(forKey: ResultValues.result2Value.rawValue)
        let value3 = UserDefaults.standard.integer(forKey: ResultValues.result3Value.rawValue)
        let value4 = UserDefaults.standard.integer(forKey: ResultValues.result4Value.rawValue)
        let value5 = UserDefaults.standard.integer(forKey: ResultValues.result5Value.rawValue)
        var values = [value1, value2, value3, value4, value5]
        
        if sender == pulldownButton[0] {
            for index in 0..<values.count {
                values[index] += 1
                UserDefaults.standard.setValue(values[index], forKey: "\(ResultValues.allCases[index])")
                print(#function, "emotion\(index + 1)Count", UserDefaults.standard.integer(forKey: "\(ResultValues.allCases[index])"))
            }
        } else if sender == pulldownButton[1] {
            for index in 0..<values.count {
                values[index] += 5
                UserDefaults.standard.setValue(values[index], forKey: "\(ResultValues.allCases[index])")
                print(#function, "emotion\(index + 1)Count", UserDefaults.standard.integer(forKey: "\(ResultValues.allCases[index])"))
            }
        } else if sender == pulldownButton[2] {
            for index in 0..<values.count {
                values[index] += 10
                UserDefaults.standard.setValue(values[index], forKey: "\(ResultValues.allCases[index])")
                print(#function, "emotion\(index + 1)Count", UserDefaults.standard.integer(forKey: "\(ResultValues.allCases[index])"))
            }
        }
    }
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        let value1 = UserDefaults.standard.integer(forKey: ResultValues.result1Value.rawValue)
        let value2 = UserDefaults.standard.integer(forKey: ResultValues.result2Value.rawValue)
        let value3 = UserDefaults.standard.integer(forKey: ResultValues.result3Value.rawValue)
        let value4 = UserDefaults.standard.integer(forKey: ResultValues.result4Value.rawValue)
        let value5 = UserDefaults.standard.integer(forKey: ResultValues.result5Value.rawValue)
        var values = [value1, value2, value3, value4, value5]
        
        for index in 0..<values.count {
            values[index] = 0
            UserDefaults.standard.setValue(values[index], forKey: "\(ResultValues.allCases[index])")
            print(#function, "emotion\(index + 1)Count", UserDefaults.standard.integer(forKey: "\(ResultValues.allCases[index])"))
        }
    }
    
    
}
