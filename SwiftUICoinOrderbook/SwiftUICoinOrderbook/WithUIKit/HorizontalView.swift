//
//  HorizontalView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import SwiftUI

struct HorizontalView: View {
    
    @StateObject var viewModel = HorizontalViewModel(market: Market(market: "비트코인", korean: "비트코인", english: "Bitcoin")) // 뷰모델이 달라지는 신호 StateObject
    
    var body: some View {
        ScrollView {
            Text(viewModel.market.korean)
            
            GeometryReader { proxy in
                // GeometryReader: 하위 뷰의 입장에서 상위 뷰의 사이즈를 알고싶을때, 컨테이너 역할
                
                let graphWidth = proxy.size.width * 0.7 //차트 최대 너비
                // VStack에 대한 size, 알고싶은 정보에 감싸주면 됨
                
                VStack {
                    ForEach(viewModel.askOrderBook, id: \.id) { item in
                        HStack {
                            Text(item.price.formatted())
                                .frame(width: proxy.size.width * 0.2)
                            ZStack(alignment: .leading) {
                                
                                let graphSize = item.size / viewModel.largestAskSize() * graphWidth
                                
                                Rectangle()
                                    .foregroundStyle(.blue.opacity(0.3))
                                    .frame(maxWidth: graphSize, alignment: .leading)
                                Text(item.size.formatted())
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: .infinity)
                            .background(.gray)
                        }
                        .frame(height: 40)
                    }
                }
                .background(.green)
            }
        }
        .onAppear {
            viewModel.timer()
            viewModel.fetchOrderbook()
        }
    }
}

#Preview {
    HorizontalView()
}
