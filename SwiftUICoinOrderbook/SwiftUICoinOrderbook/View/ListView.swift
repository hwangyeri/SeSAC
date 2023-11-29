//
//  ListView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/21.
//

import SwiftUI

struct ListView: View {
    
    // 뷰모델이 가진 마켓 데이터 필요
    //@ObservedObject var viewModel = ListViewModel()
    // 주의해서 사용할 필요가 있음, 해결법: StateObject 쓰면 됨
    
    // StateObject 로 교체
    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        LazyVStack {
            Button("서버 통신") { 
                viewModel.fetchAllMarket()
                // 버튼을 눌렀을때 서버 통신
            }
            ForEach(viewModel.market, id: \.self) { item in
                NavigationLink(value: item) {
                    HStack {
                        VStack(alignment: .center) {
                            Text(item.korean)
                                .bold()
                            Text(item.english)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text(item.market)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            print("================")
            //viewModel.fetchAllMarket()
            // ObservedObject로 테스트
            // 초기화가 되었지만 돌아오는 시점에서 onAppear로 서버통신
            // 뷰가 보일 때마다 서버통신 => 어마어마한 과호출이 일어나고 있음
        }
        .navigationDestination(for: Market.self) { item in
            let viewModel = HorizontalViewModel(market: item)
            HorizontalView(viewModel: viewModel)
        }
    }
}

#Preview {
    ListView()
}
