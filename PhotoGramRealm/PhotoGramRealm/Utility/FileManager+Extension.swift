//
//  FileManager+Extension.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/05.
//

import UIKit

extension UIViewController {

    func documentDirectoryPath() -> URL? {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func removeImageFromDocument(fileName: String) {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //2. 저장할 경로 설정(세부 경로, 이미지를 저장되어 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
        
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")! }
        //2. 저장할 경로 설정(세부 경로, 이미지를 저장되어 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)! // 시간이 걸리진않음
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
    }
    
    //도큐먼트 폴더에 이미지를 저장하는 메서드
    func saveImageToDocument(fileName: String, image: UIImage) {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // 도큐먼트 폴더까지 들어옴
        //2. 저장할 경로 설정(세부 경로, 이미지를 저장할 위치)
        //file:///Users/hwang_yeri/Library/Developer/CoreSimulator/Devices/4822BE95-1144-40D4-A770-EB39CDB060C0/data/Containers/Data/Application/7597F590-6DA6-456B-901B-D7467B85E741/Documents/123.jpg
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 이 경로에 저장할게 ~ 라고 선언이 필요
        
        //3. 이미지 변환
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        //4. 이미지 저장
        do {
            try data.write(to: fileURL) // 애플이 데이터 저장할때 try 구문 사용하라고 함
        } catch let error {
            print("file save error", error) // 사용자에게 액션을 취해야함
        }
        
    }
    
    
}
