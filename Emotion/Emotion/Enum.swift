//
//  Enum.swift
//  Emotion
//
//  Created by 황예리 on 2023/07/26.
//

import Foundation

enum EmtionImageName: String, CaseIterable {
    case emoji1
    case emoji2
    case emoji3
    case emoji4
    case emoji5
}

enum PulldownButtonTitle: String, CaseIterable {
    case Pulldown1Button = " 1"
    case Pulldown5Button = " 5"
    case Pulldown10Button = " 10"
}

enum EmotionLableType: String, CaseIterable {
    case 완전행복지수
    case 적당미소지수
    case 그냥그냥지수
    case 좀속상한지수
    case 많이슬픈지수
}

enum ResultValues: String, CaseIterable {
    case result1Value
    case result2Value
    case result3Value
    case result4Value
    case result5Value
}

enum EmotionButtonType: Int, CaseIterable {
    case emotion1Button = 0
    case emotion2Button
    case emotion3Button
    case emotion4Button
    case emotion5Button

    var title: String {
        switch self {
        case .emotion1Button: return "result1Value"
        case .emotion2Button: return "result2Value"
        case .emotion3Button: return "result3Value"
        case .emotion4Button: return "result4Value"
        case .emotion5Button: return "result5Value"
        }
    }
}

