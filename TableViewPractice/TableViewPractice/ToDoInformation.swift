//
//  ToDoInformation.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import UIKit

struct ToDoInformation { //식판 받을 수 있는 곳, 식판 반환하는 곳
    
    //타입 메서드는 인스턴스 생성과 상관없이 사용 가능!
    static func randomBackgroundColor() -> UIColor { //인스턴스 메서드
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    //인스턴스 프로퍼티
    var list = [
        ToDo(main: "잠자기", sub: "오늘까지", like: false, done: true, color: randomBackgroundColor()),
        ToDo(main: "쇼핑하기", sub: "주말까지", like: true, done: false, color: randomBackgroundColor()),
        ToDo(main: "바다가기", sub: "내일까지", like: false, done: false, color: randomBackgroundColor())
    ]
}

/*
     func randomBackgroundColor(), var list 동일한 시점에 실행됨 (초기화 시점)
     static func randomBackgroundColor() 타입 메서드로 바꾸면 시점 상관없이 사용가능
     static 고유한 자신만의 공간을 차지함, default로 lazy하게 동작
     필요한 시점에 사용할 수 있게 구성해야함
 */
