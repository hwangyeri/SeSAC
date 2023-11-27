//
//  HorizontalView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import SwiftUI

struct HorizontalView: View {
    
    @StateObject var viewModel = HorizontalViewModel()
    
    var body: some View {
        ScrollView {
            Text("\(viewModel.value)")
            
            GeometryReader { proxy in
                
                let graphWidth = proxy.size.width // VStack에 대한 size, 알고싶은 정보에 감싸주면 됨
                
                VStack {
                    ForEach(horizontalDummy, id: \.id) { item in
                        HStack {
                            Text(item.data)
                                .frame(width: proxy.size.width * 0.2)
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .foregroundStyle(.blue.opacity(0.3))
                                    .frame(width: CGFloat(item.point) / 10)
                                    .frame(maxWidth: graphWidth * 0.7)
                                Text(item.point.formatted())
                            }
                            .frame(maxWidth: .infinity)
                            .background(.gray)
                        }
                        .frame(height: 40)
                    }
                }
                .background(.green)
                .onTapGesture {
                    //print(horizontalDummy)
                    //print(largest())
                    viewModel.timer()
                    print(proxy)
                    print(proxy.size)
                }
            }
        }
    }
}

#Preview {
    HorizontalView()
}
