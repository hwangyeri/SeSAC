//
//  Movie.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import Foundation
import UIKit

struct Movie {
    var imageName: String
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
    
    var subLableTitle: String {
        get {
            return "\(releaseDate) | \(runtime)분 | \(rate)점"
        }
    }
}
