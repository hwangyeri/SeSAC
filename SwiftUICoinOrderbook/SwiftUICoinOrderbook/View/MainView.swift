//
//  MainView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/20.
//

import SwiftUI

import SwiftUI

struct MainView: View {
    
    @State private var banner = "23,456,789,467,700원"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    bannerView()
                    Button("테스트") {
                        
                    }
                    Button("데이터 로드") {
                        
                    }
                    .padding()
                    LazyVStack { // 필요한 시점에 로드
                        ForEach(dummy, id: \.id) { item in
                            listView(dummy: item)
                        }
                    }
                }
            }
            .refreshable { //iOS15+
                banner = "54,324,243원"
            }
            .navigationTitle("Yeri Wallet")
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.indigo)
                .frame(maxWidth: .infinity)
                .frame(height: 180)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                Text(banner)
                    .font(.title)
                    .bold()
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
    func listView(dummy: Money) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text(dummy.product)
                    .font(.title3)
                Text(dummy.category.rawValue)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .bold()
            Spacer()
            Text(dummy.amountFormat)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
    }
    
}

#Preview {
    MainView()
}
