//
//  UserDefaultsGroup.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/30.
//

import Foundation

extension UserDefaults {
    
    static var groupShared: UserDefaults {
        let appGroupID = "group.yerihwang.SwiftUICoinOrderbook.Wellet"
        
        return UserDefaults(suiteName: appGroupID)!
    }
}
