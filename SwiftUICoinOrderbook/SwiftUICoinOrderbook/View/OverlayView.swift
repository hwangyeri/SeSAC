//
//  OverlayView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/21.
//

import SwiftUI

struct OverlayView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.orange)
                    .frame(width: 150, height: 150)
                Text("안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요")
            }
            
            Circle()
                .fill(.yellow)
                .frame(width: 150, height: 150)
                .overlay {
                    Text("안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요 안녕하세요")
                }
            // overlay - 뷰의 수가 적어진다는 장점
            // 글자를 늘리면 보여지는 결과가 다름
            // ZStack는 각자 사이즈에 크기가 제각각이고 독립적임, 무한정 늘어남
            // 반면에 overlay는 addSubView 같은 것, 부모뷰 안에 자식뷰, 안에서 늘어남
        }
    }
}

#Preview {
    OverlayView()
}
