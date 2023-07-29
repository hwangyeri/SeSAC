//
//  ToDoInformation.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import Foundation

struct ToDoInformation { //식판 받을 수 있는 곳, 식판 반환하는 곳
    var list = [
        ToDo(main: "잠자기", sub: "오늘까지", like: false, done: true),
        ToDo(main: "쇼핑하기", sub: "주말까지", like: true, done: false),
        ToDo(main: "바다가기", sub: "내일까지", like: false, done: false)
    ]
}
