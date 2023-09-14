//
//  AppDelegate.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { // 앱을 정식으로 출시하면 영영 지우지 못하는 레거시 코드
        //컬럼과 테이블 단순 추가 삭제의 경우엔 별도 코드가 필요없음 // 보통 정수 단위로 1씩 올라감
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in // 스키마 버전 업데이트
            
            if oldSchemaVersion < 1 { } // diaryPin Column 추가 // 클로저 안에 생략되도 알아서 해줌
            
            if oldSchemaVersion < 2 { } // diaryPin Column 삭제
            
            if oldSchemaVersion < 3 { // diaryPhoto -> photo Column 이름 변경
                migration.renameProperty(onType: DiaryTable.className(), from: "diaryPhoto", to: "photo")
            }
            
            if oldSchemaVersion < 4 { // diaryContents -> contents Column 컬럼명 변경
                migration.renameProperty(onType: DiaryTable.className(), from: "diaryContents", to: "contents")
            }
            
            if oldSchemaVersion < 5 { // diarySummery 컬럼 추가, title + contents 합쳐서 넣기 // 이미 있는 기본값을 넣는 것
                migration.enumerateObjects(ofType: DiaryTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["diarySummery"] = "제목은'\(old["diaryTitle"])'이고, 내용은 '\(old["contents"])'입니다"
                }
            }
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

