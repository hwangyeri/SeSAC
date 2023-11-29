//
//  HorizontalData.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation

struct HorizontalData: Identifiable {
    let id = UUID()
    let data: String
    let point = Int.random(in: 100...5000)
}
