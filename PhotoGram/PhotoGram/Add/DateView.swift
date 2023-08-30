//
//  DateView.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit
import SnapKit

class DateView: BaseView {
    
    let picker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        return view
    }()
    
    override func configureView() {
        addSubview(picker)
    }
    
    override func setConstraints() {
        picker.snp.makeConstraints { make in
            //UIDatePicker 기본적인 크기는 정해져있음
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}
