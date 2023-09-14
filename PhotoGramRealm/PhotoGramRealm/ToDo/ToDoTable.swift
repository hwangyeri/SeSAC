//
//  ToDoTable.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/08.
//

import Foundation
import RealmSwift

class ToDoTable: Object { // 큰 할일
    
    // Primary Key 검색을 하는 기준, 없다고 오류안남 하지만, 여러개 만들면 런타임 오류 // 보통 하나정도는 있음
    // Primary Key 기본적으로 인덱스 속성이 들어가있어서 탐색하는데 속도가 빠름
    // If, 500 페이지에서 찾을때 - 정리된 단어, 목차로 검색하면 빠르게 찾을 수 있음
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var favorite: Bool
    
    //To Many Relationship 일대다 관계
    @Persisted var detail: List<DetailTable> // 빈배열이라고 이해하면 쉬움 // 작은 할일 - 한방향으로 흘러감, 단방향 // 투두의 입장에서 디테일을 다 알게됨
    
    //To One Relationship: EmbeddedObject 일대일 관계 //별도의 테이블이 생성되는 형태는 아님
    @Persisted var memo: Memo? //무조건 옵셔널 필수
    
    convenience init(title: String, favorite: Bool) {
        self.init()
        
        self.title = title
        self.favorite = favorite
        
    }
}

class DetailTable: Object { // 작은 할일
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var detail: String
    @Persisted var deadline: Date
    
    //Inverse Relationship Property (LinkingObjects) 역관계
    //투두는 디테일이 대해 알 수 있지만, 디테일은 투두에 대해서 모르기때문에 역관계 정의가 필요
    @Persisted(originProperty: "detail") var mainToDo: LinkingObjects<ToDoTable> // 본질적인 프로퍼티는 누구야? // 부모 테이블 명시
    
    convenience init(detail: String, deadline: Date) {
        self.init()
        
        self.detail = detail
        self.deadline = deadline
        
    }
}

class Memo: EmbeddedObject {
    // 하나의 컬럼 단위, 단일한  Object는 아님 // 하나의 뭉텅이를 테이블 구조안에 넣고 싶을때 사용
    // 하나의 테이블이 아닌 인스턴스로 생성
    @Persisted var content: String
    @Persisted var date: Date
}
