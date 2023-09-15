//
//  DiaryTable.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/04.
//

import Foundation
import RealmSwift

// 컬럼명을 바꿈 -> 테이블이 바뀐 것, 런타임 오류 발생 // 대응하는 코드 필요 or 앱 지우고 다시 설치하기

class DiaryTable: Object { // DiaryTable -> Diary 로 이름 구성하는 것도 괜찮음
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var diaryTitle: String //일기 제목 (필수) // dairyTitle -> title 잘 알아볼 수 있거나 애플이 지정해놓은 예약어랑 겹치지않게 이름 짓기
    @Persisted var diaryDate: Date //일기 등록 날짜 (필수)
    @Persisted var contents: String? //일기 내용 (옵션)
    @Persisted var photo: String? //일기 사진 URL (옵션)
    @Persisted var diaryLike: Bool //즐겨찾기 기능(필수)
    //@Persisted var diaryPin: Bool
    @Persisted var diarySummery: String // 일기 요약

    convenience init(diaryTitle: String, diaryDate: Date, diaryContents: String?, diaryPhoto: String?) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.diaryDate = diaryDate
        self.contents = diaryContents
        self.photo = diaryPhoto
        self.diaryLike = true
        self.diarySummery = "제목은'\(diaryTitle)'이고, 내용은 '\(contents)'입니다"
        
    }
    
}

