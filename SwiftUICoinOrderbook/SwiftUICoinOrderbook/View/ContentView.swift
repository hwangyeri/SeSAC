//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    
// 뷰모델로 데이터 이전
//    @State private var banner = "23,456,789,467,700원"
//    //@State private var money: [Money] = []
//    @State private var money: [Market] = [] // 전달 받은 데이터 타입으로 전환
    
    @ObservedObject var viewModel = ContentViewModel()
    // 데이터를 담고있는 뷰모델이 필요
    // Published 신호를 보내면 받아줄 ObservedObject 필요
    // @StateObject 최근에 등장, @ObservedObject 처음부터 있었음
    // ObservedObject가 신호를 받아서 수정될 수 있도록 해줌
    
    @State var renderingTestNumber = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("테스트: \(renderingTestNumber)")
                // NavigationLink를 누르면 renderingTestNumber 전달할게
                NavigationLink("배너 테스트", value: renderingTestNumber)
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(1..<5) { data in
                                bannerView()
                                    .containerRelativeFrame(.horizontal) //iOS17+
                                    .onTapGesture {
                                        // @ObservedObject 데이터 유지됨
                                        // @StateObject 데이터 초기화됨
                                        viewModel.fetchBanner()
                                    }
                            }
                        }
                        //스크롤 하고자 하는 대상에 대한 레이아웃 설정
                        .scrollTargetLayout()
                    }
                    // viewAligned 뷰 기준으로 중앙애 맞춰줌
                    // paging 프레임 기준
                    .scrollTargetBehavior(.viewAligned)
                    // 회전목마, 사이드 양옆에 살짝 보이는 형태
                    //.safeAreaPadding([.horizontal], 40)
                    .scrollIndicators(.automatic) //자식뷰 설정이 우선됨
                    
                    ListView() // 하위뷰
                    // 상위뷰에 있는 데이터 변경된 후 바디를 다시 그리고,
//                    LazyVStack { // 필요한 시점에 로드 (최적화 측면 고려)
//                        ForEach(viewModel.money, id: \.self) { data in
//                            listView(data: data)
//                        }
//                    }
                }
            }
            .scrollIndicators(.hidden) // 스크롤 인디케이터 숨기기, 부모뷰에 설정이 되면 자식뷰도 영향을 받음
            .refreshable { //iOS15+
                viewModel.fetchBanner()
                //viewModel.banner = "54,324,243원"
                //money = dummy.shuffled()
                renderingTestNumber = Int.random(in: 1...100)
            }
                
//            .onAppear { // viewWillAppear 같은 친구, 화면이 뜰때마다 설정
//                UpbitAPI.fetchAllMarket { market in
//                    // 응답 받은 데이터 사용할 준비 필요
//                    viewModel.money = market
//                }
//                //money = dummy.shuffled()
//            }
            .navigationTitle("Yeri Wallet")
            .navigationDestination(for: Int.self) { _ in
                BannerTestView(testNumber: $renderingTestNumber)
            }
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(viewModel.banner.color.opacity(0.7))
                .overlay {
                    Circle()
                        .fill(viewModel.banner.color)
                        .offset(x: -90, y: -20)
                        .scaleEffect(1.3, anchor: .topLeading)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(maxWidth: .infinity)
                .frame(height: 170)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.title3)
                Text(viewModel.banner.totalFormat)
                    .font(.title)
                    .bold()
            }
            //스크롤시, 타이틀이 액티브하게 움직이는 애니메이션 기능
//            .visualEffect { content, geometryProxy in
//                content.offset(x: scrollOffset(geometryProxy))
//            }
            .foregroundStyle(.white)
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
    //GeometryProxy: 컨테이너 뷰에 대한 좌표나 크기에 접근할 수 있음!!
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        // 어디에서 멈추는지 좌표값이 필요함
        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
        return -result
    }
    
// 별도의 구조체로 덜어낸 상황이라 필요없음
//    func listView(data: Market) -> some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(data.korean)
//                    .font(.title3)
//                Text(data.english)
//                    .font(.caption)
//                    .foregroundStyle(.gray)
//            }
//            .bold()
//            Spacer()
//            Text(data.market) // 구조체 내에 있는 프로퍼티를 가져올 수 있도록 하나씩 교체해주기
//        }
//        .padding(.vertical, 20)
//        .padding(.horizontal, 30)
//    }
    
}

#Preview {
    ContentView()
}
