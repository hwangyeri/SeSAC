//
//  GenreData.swift
//  Media
//
//  Created by 황예리 on 2023/09/03.
//

import Foundation

enum Genre: Int {
    // Movie List
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    // TV List
    case actionAdventure = 10759
    case kids = 10762
    case news = 10763
    case reality = 10764
    case sciFiFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    
    var description: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .animation: return "Animation"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .documentary: return "Documentary"
        case .drama: return "Drama"
        case .family: return "Family"
        case .fantasy: return "Fantasy"
        case .history: return "History"
        case .horror: return "Horror"
        case .music: return "Music"
        case .mystery: return "Mystery"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .tvMovie: return "TV Movie"
        case .thriller: return "Thriller"
        case .war: return "War"
        case .western: return "Western"
        case .actionAdventure: return "Action & Adventure"
        case .kids: return "Kids"
        case .news: return "News"
        case .reality: return "Reality"
        case .sciFiFantasy: return "Sci-Fi & Fantasy"
        case .soap: return "Soap"
        case .talk: return "Talk"
        case .warPolitics: return "War & Politics"
        }
    }
    
}
