//
//  ViewController.swift
//  LEDBoard
//
//  Created by 황예리 on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var mainTextField: UITextField!
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var randomColorChangeButton: UIButton!
    
    @IBOutlet var resultLable: UILabel!
    
    @IBOutlet var backgroundView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextFieldStyle()
        submitButtonStyle()
        randomColorChangeButtonStyle()
        resultLableStyle()
        backgroundViewStyle()
    }

    //TextField
    func mainTextFieldStyle() {
        mainTextField.placeholder = "문구를 입력하세요. 😎"
        mainTextField.textColor = .black
        mainTextField.backgroundColor = .none
        mainTextField.font = .systemFont(ofSize: 20)
        mainTextField.borderStyle = .none
        mainTextField.autocorrectionType = .no
        
        //leadingPadding
        let leadingPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        mainTextField.leftView = leadingPaddingView
        mainTextField.leftViewMode = .always
    }
    
    //Button
    func submitButtonStyle() {
        submitButton.tintColor = .black
        submitButton.backgroundColor = .white
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 12
    }
    
    func randomColorChangeButtonStyle() {
        randomColorChangeButton.tintColor = .red
        randomColorChangeButton.backgroundColor = .white
        randomColorChangeButton.layer.borderColor = UIColor.black.cgColor
        randomColorChangeButton.layer.borderWidth = 2
        randomColorChangeButton.layer.cornerRadius = 12
    }
    
    //Lable
    func resultLableStyle() {
        resultLable.font = .systemFont(ofSize: 100)
        resultLable.textColor = .red
        resultLable.textAlignment = .center
        resultLable.numberOfLines = 1
    }
    
    //StackView
    func backgroundViewStyle() {
        backgroundView.layer.cornerRadius = 12
        backgroundView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    //Action
    @IBAction func clickedSubmitButton(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func tappedDisplayTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func tappedTopBarTapGesture(_ sender: UITapGestureRecognizer) {
        backgroundView.isHidden.toggle()
        print(#function)
    }
    
    @IBAction func clickedMainTextField(_ sender: UITextField) {
        resultLable.text = mainTextField.text
    }
    
    @IBAction func clickedRandomColorChangeButton(_ sender: UIButton) {
        let colrList = [UIColor.red, UIColor.blue, UIColor.green, UIColor.cyan, UIColor.purple, UIColor.orange, UIColor.magenta]
        let randomColor = colrList.randomElement()!
        
        resultLable.textColor = randomColor
        randomColorChangeButton.tintColor = randomColor
    }
    
    
}

