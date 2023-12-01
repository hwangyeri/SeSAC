//
//  WidgetTabView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/30.
//

import SwiftUI

struct WidgetTabView: View {
    
    @State private var selectedTab = "pencil"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("1111", action: {
                selectedTab = "star"
            })
                .tabItem { Image(systemName: "book") }
                .tag("book")
            Text("2")
                .tabItem { Image(systemName: "star") }
                .tag("star")
            Text("3")
                .tabItem { Image(systemName: "pencil") }
                .tag("pencil")
        }
        .onOpenURL {
            switch $0.absoluteString {
            case "History": selectedTab = "book"
            case "Favorite": selectedTab = "star"
            default: selectedTab = "pencil"
            }
        }
    }
}

#Preview {
    WidgetTabView()
}
