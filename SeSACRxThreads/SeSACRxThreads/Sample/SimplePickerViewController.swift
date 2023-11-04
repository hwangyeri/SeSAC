//
//  SimplePickerViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimplePickerViewController: ViewController {
    
    let pickerView1: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let pickerView2: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let pickerView3: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let resultLabel1: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "result"
        return label
    }()
    
    let resultLabel2: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "result"
        return label
    }()
    
    let resultLabel3: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "result"
        return label
    }()
    
    let tempButton: UIButton = {
       let button = UIButton()
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureLayout()
        
//        setPickerView()
        setButton()
    }
    
    func setButton() {
        
        // subscribe: 메인쓰레드에서 동작하게 변경 필요, next.error.completed 이벤트 처리
        // bind: next 이벤트만 처리
        
        tempButton.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.resultLabel1.text = "hi"
            }
            .disposed(by: disposeBag)
        
        tempButton.rx.tap
            .bind { _ in
                self.resultLabel1.text = "hello"
            }
            .disposed(by: disposeBag)
        
        tempButton.rx.tap
            .map { "안녕" }
            .bind(to: resultLabel1.rx.text)
            .disposed(by: disposeBag)
        
        tempButton.rx.tap
            .map { "안녕하세요" }
            .asDriver(onErrorJustReturn: "error")
            .drive(resultLabel1.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setPickerView() {
        
        let item = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        item
            .bind(to: pickerView1.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: resultLabel1.rx.text) 
            // bind: onNext만 가능, 보통 Main Thread 에서 동작하기 때문에 주로 사용
            // subscribe: onNext, onError, onCompleted, onDisposed 전부 가능
            .disposed(by: disposeBag)
        
        let num = [10, 22, 34, 64]
        Observable.from(optional: num)
            .bind(to: pickerView2.rx.itemAttributedTitles) { row, item in
                return NSAttributedString(string: "\(item)", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.systemTeal,
                    NSAttributedString.Key.underlineColor: UIColor.systemTeal,
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.patternDash.rawValue
                ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .map { $0.description }
            .bind(to: resultLabel2.rx.text)
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.blue, UIColor.green])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { color in
                print("selected color: \(color)")
            })
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
//        [pickerView1, resultLabel1, pickerView2, resultLabel2, pickerView3, resultLabel3].forEach {
//            view.addSubview($0)
        view.addSubview(tempButton)
        view.addSubview(resultLabel1)
        
        tempButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(80)
        }
        
        resultLabel1.snp.makeConstraints { make in
            make.bottom.equalTo(tempButton.snp.top).offset(-50)
            make.horizontalEdges.equalToSuperview().inset(50)
        }
        
//        resultLabel1.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalToSuperview()
//        }
//        
//        pickerView1.snp.makeConstraints { make in
//            make.top.equalTo(resultLabel1.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//        }
//        
//        resultLabel2.snp.makeConstraints { make in
//            make.top.equalTo(pickerView1.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//        }
//        
//        pickerView2.snp.makeConstraints { make in
//            make.top.equalTo(resultLabel2.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//        }
//        
//        resultLabel3.snp.makeConstraints { make in
//            make.top.equalTo(pickerView2.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//        }
//        
//        pickerView3.snp.makeConstraints { make in
//            make.top.equalTo(resultLabel3.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
    }
    
    
    
}
