//
//  Enum.swift
//  Emotion
//
//  Created by 황예리 on 2023/07/26.
//

import Foundation

//ButtonImage
enum EmtionImageName: String, CaseIterable {
    case 완전행복지수 = "emoji1"
    case 적당미소지수 = "emoji2"
    case 그냥그냥지수 = "emoji3"
    case 좀속상한지수 = "emoji4"
    case 많이슬픈지수 = "emoji5"
}

//ButtonTitle
enum PulldownButtonTitle: String, CaseIterable {
    case Pulldown1Button = " 1"
    case Pulldown5Button = " 5"
    case Pulldown10Button = " 10"
}

//LableTitle
enum emotionTypeLableTitle: String, CaseIterable {
    case 완전행복지수
    case 적당미소지수
    case 그냥그냥지수
    case 좀속상한지수
    case 많이슬픈지수
}
