//
//  RealmModel.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/09/05.
//

import Foundation
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var bookTitle: String // 도서 제목 (필수)
    @Persisted var bookAuthors: String // 도서 작가 (필수)// [String]
    @Persisted var bookContents: String // 도서 설명 (필수)
    @Persisted var bookPrice: Int // 도서 가격 (필수)
    @Persisted var bookSalePrice: Int // 도서 할인 가격 (필수)
    @Persisted var bookThumbnail: String // 도서 썸네일 (필수)
    @Persisted var bookURL: String // 도서 url (필수)
    @Persisted var bookPublisher: String // 도서 출판사 (필수)
    @Persisted var bookDateTime: Date // 도서 발매일 (필수)
    @Persisted var bookStatus: String // 도서 상태 (필수)
    
    convenience init(bookTitle: String, bookAuthors: String, bookContents: String, bookPrice: Int, bookSalePrice: Int, bookThumbnail: String, bookURL: String, bookPublisher: String, bookDateTime: Date, bookStatus: String) {
        self.init()
        
        self.bookTitle = bookTitle
        self.bookAuthors = bookAuthors
        self.bookContents = bookContents
        self.bookPrice = bookPrice
        self.bookSalePrice = bookSalePrice
        self.bookThumbnail = bookThumbnail
        self.bookURL = bookURL
        self.bookDateTime = bookDateTime
        self.bookStatus = bookStatus
        
    }
    
}
