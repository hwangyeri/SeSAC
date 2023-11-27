//
//  HorizontalData.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation

struct HorizontalData: Identifiable {
    let id = UUID()
    let data: String
    let point = Int.random(in: 100...3000)
}

let horizontalDummy = [
    HorizontalData(data: "사과"),
    HorizontalData(data: "포도"),
    HorizontalData(data: "바나나"),
    HorizontalData(data: "복숭아"),
    HorizontalData(data: "귤"),
    HorizontalData(data: "딸기"),
    HorizontalData(data: "참외"),
    HorizontalData(data: "수박"),
    HorizontalData(data: "멜론")
]

func largest() -> Int {
    let data = horizontalDummy.sorted(by: { $0.point > $1.point })
    return data.first!.point
}
