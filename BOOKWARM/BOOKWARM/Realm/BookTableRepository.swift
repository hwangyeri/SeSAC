//
//  BookTableRepository.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/09/06.
//

import Foundation
import RealmSwift

protocol BookTableRepositoryType: AnyObject {
    func fetch() -> Results<BookTable>
    func createItem(_ item: BookTable)
}

class BookTableRepository: BookTableRepositoryType {
    
    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    // Realm Read
    func fetch() -> Results<BookTable> {
        
        let data = realm.objects(BookTable.self).sorted(byKeyPath: "bookTitle", ascending: false)
        
        return data
    }
    
    //Reaml Create
    func createItem(_ item: BookTable) {
        
        do {
            try realm.write {
                realm.add(item)
                print("Realm Add Succeed")
            }
        } catch {
            print(error)
        }
        
    }
    
    //Reaml Update
    func updateItem(id: ObjectId, memo: String) {
        
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": id, "bookMemo": memo], update: .modified)
                print("Realm Update Succeed")
            }
        } catch {
            print(error)
        }
        
    }
    
    //Realm Delete
    func deleteItem(_ item: BookTable) {
        
        do {
            try realm.write {
                realm.delete(item)
                print("Realm Delete Succeed")
            }
        } catch {
            print(error)
        }
        
    }
    
    
}
