//
//  Provider.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/30.
//

import WidgetKit

struct Provider: TimelineProvider {
    
    typealias Entry = SimpleEntry // 구체 타입 명시
    
    //위젯킷이 최초로 랜더링할 때 사용 > 스켈레톤 뷰 랜더링
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), test: "Yeri", token: "토큰", price: 123456789)
    }

    //위젯 갤러리 미리보기 화면 설정
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), test: "test", token: "token", price: 0987654321)
        completion(entry)
    }

    //위젯 상태 변경 시점 설정
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 { // 대략적인 추세를 등록, 시간마다 타임라인 구성
            let entryDate = Calendar.current.date(
                byAdding: .minute,
                value: hourOffset,
                to: currentDate)!
            let entry = SimpleEntry(date: Date(), test: "SeSAC", token: "iOS 3기", price: .random(in: 100...1000000))
            entries.append(entry)
        }

        //타임라인 마지막 날짜가 지난 뒤, 위젯킷이 새로운 타임라인을 요청할 수 있도록 설정
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}
