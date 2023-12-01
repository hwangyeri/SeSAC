//
//  CustomOrderbook.swift
//  CustomOrderbook
//
//  Created by Yeri Hwang on 2023/11/29.
//

import WidgetKit
import SwiftUI

struct CustomOrderbook: Widget {
    let kind: String = "CustomOrderbook" //위젯 고유한 문자열

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CustomOrderbookEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget) // 설정한 배경화면에 따라서 잘 보일 수 있도록 컬러, 등을 자연스럽게 바꿔줄게
            } else {
                CustomOrderbookEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("보유 코인")
        .description("실시간 시세를 확인하세요.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//#Preview(as: .systemSmall) {
//    CustomOrderbook()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
