//
//  ViewModelType.swift
//  Setting
//
//  Created by Yeri Hwang on 2023/11/15.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
