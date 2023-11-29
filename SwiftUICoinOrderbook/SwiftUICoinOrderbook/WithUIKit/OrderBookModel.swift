//
//  OrderBookModel.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation

struct OrderBookModel: Decodable { //S
    let market: String
    let timestamp: Int
    let total_ask_size, total_bid_size: Double
    let orderbook_units: [OrderBookUnit]
}

struct OrderBookUnit: Decodable { //S
    let ask_price, bid_price: Double
    let ask_size, bid_size: Double
}

struct OrderBookItem: Hashable, Identifiable { //V
    let id = UUID()
    let price: Double
    let size: Double
}
