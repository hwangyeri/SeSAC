//
//  DateFormat+Extension.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/29.
//

import Foundation

extension DateFormatter {
    
    static let format = {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        return format
    }()
    
    static func today() -> String {
        return format.string(from: Date())
    }
    
    static func convertDate(date: Date) -> String {
        return format.string(from: date)
    }
    
    
}
