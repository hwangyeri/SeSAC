//
//  DiaryTableRepository.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/06.
//

import Foundation
import RealmSwift

// 테이블이 하나밖에 존재하지않는 곳에서 꼭 프로토콜을 사용해야하는 것은 아니지만, 나중에 해당 프로토콜을 채택하면 어떤 기능들이 있구나를 한눈에 알 수 있음 // 코드로 커뮤니케이션하는 직업이기 때문에!
protocol DiaryTableRepositoryType: AnyObject { // AnyObject 클래스에서만 사용
    func fetch() -> Results<DiaryTable>
    func fetchFilter() -> Results<DiaryTable>
    func createItem(_ item: DiaryTable)
}

class DiaryTableRepository: DiaryTableRepositoryType { // Reaml 자체가 클래스여서 클래스로 만듦
    
    // 외부에서 접근할 일이 없어서 private 붙임
    private let realm = try! Realm() //realm 파일에 접근할 수 있도록, 위치를 찾는 코드 // 도큐먼트 경로를 찾아오는 코드
    
    private func a() { //== > 다른 파일에서 쓸 일 없고, 클래스 안에서만 쓸 수 있음 => 오버라이딩 불가능 => final 키워드를 잠재적으로 유추
        
    }
    
    func checkSchemaVersion() { // 스키마 버전을 알려달라는 함수
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    // Realm Read
    func fetch() -> Results<DiaryTable> {
        
        let data = realm.objects(DiaryTable.self).sorted(byKeyPath: "diaryTitle", ascending: false) // 정렬해서 데이터를 가져옴
        // 내용 추가시, 제목순으로 정렬, 내림차순 true
        // 메타타입 데이블뷰 그 자체를 가져오는 것 // 영구적으로 데이터가 저장되는 상태
        return data // 뷰에 던져주려면 반환값이 필요
    }
    
    func fetchFilter() -> Results<DiaryTable> { // 매개변수 내에서 조건을 달아서 안에서 구현하는 경우, 기능 별 메서드를 여러개 만드는 경우, 여러 방법이 있음
        
        let result = realm.objects(DiaryTable.self).where { // 데이터를 필터하는 기능
            // fetch().where 로 바꿔줄수도 있지만 뒤에 정렬하는 코드 추가해야함
            
            //1. caseInsensitive - 대소문자 구별 없음
            //$0.diaryTitle.contains("제목", option: .caseInsensitive) // $0 == Recode 하나
            
            //2. Bool
            //$0.diaryLike == true
            
            //3. 사진이 있는 데이터만 불러오기 (diaryPhoto의 nil 여부 판단)
            $0.photo != nil
        }
        
        return result
    }
    
    //Reaml Create
    func createItem(_ item: DiaryTable) {
        
        do {
            try realm.write { // 식판에 데이터 추가 // 레코드 만들고, 이 레코드를 써줘 ~
                realm.add(item)
                print("Realm Add Succeed")
            } // Transaction 때문에 try 구문을 써야함
        } catch {
            print(error)
        }
        
    }
    
    //Reaml Update
    func updateItem(id: ObjectId, title: String, contents: String) {
        
        do {
            try realm.write {
                
                realm.create(DiaryTable.self, value: ["_id": id, "diaryTitle": title, "diaryContents": contents], update: .modified) //특정 테이블 값 변경
                
            }
        } catch {
            print("")
        }
        
    }
    
}
