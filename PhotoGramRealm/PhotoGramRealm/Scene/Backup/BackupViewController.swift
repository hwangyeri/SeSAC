//
//  BackupViewController.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/07.
//

import UIKit // 애플의 내장된 프레임워크 -> 알파벳 순으로 정렬하는 편, case by case
import SnapKit
import Zip

class BackupViewController: BaseViewController {
    
    let backupButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let restoreButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    override func configure() {
        view.addSubview(backupTableView)
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    @objc func backupButtonTapped() {
        print(#function)
        
        //1. 백업하고자 하는 파일들의 경로 배열 생성
        var urlPaths = [URL]() // default.realm, post Folder 담긴 파일
        
        //2. 도큐먼트 위치
        guard let path = documentDirectoryPath() else {
            print("Backup 실패, 도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        //3. 백업하고자 하는 파일 경로 ex ~~~/~~/~~~/Document/default.realm
        let realmFile = path.appendingPathComponent("default.realm")
        
        //4. 3번 경로가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else { // 파일이 실제로 존재하는지 확인
            print("백업할 파일이 없습니다.")
            return
        }
        
        //5. 압축하고자 하는 파일을 배열에 추가
        urlPaths.append(realmFile)
        
        //6. 압축
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "YeriArchive_\(Int.random(in: 1...1000))")
            print("location: \(zipFilePath)")
        } catch {
            print("압축을 실패했어요..")
            // 실패시 얼럿메세지 띄워주기
        }
        
    }
    
    @objc func restoreButtonTapped() {
        print(#function)
        
        //파일 앱을 통한 복구 진행
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true) // 확장자 제어, zip 파일말고 선택할 수 없도록 설정 // archive 압축파일
        // forOpeningContentTypes: 압축파일만 가져올게 ~, asCopy: 데이터는 그대로 둔 채로 복사해서 가져올게 ~
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // 한개만 선택 가능
        present(documentPicker, animated: true)
    }
    
    override func setConstraints() {
        
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    

}

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function, urls)
        
        guard let selectedFileURL = urls.first else { //파일앱 내 선택한 파일의 URL
            print("선택한 파일에 오류가 있어요")
            return
        }
        
        guard let path = documentDirectoryPath() else { // 도큐먼트 폴더의 위치
            print("도큐먼트 위치에 오류가 있어요")
            return
        }
        
        //도큐먼트 폴더 내 저장할 경로 설정
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        // path에 파일 앱이 가지고 있는 lastPathComponent // 최종적으로 저장하고 싶은 위치를 설정
        
        //경로에 복구할 파일(zip)이 이미 있는지 확인
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("YeriArchive.zip") // 파일에 대한 URL // 압축 파일의 경로를 풀고싶은 곳
            // appendingPathComponent(앱 내에 저장이 되는 이름)
            
            do {
                // fileURL에 있는 URL을 풀거다 // 이 경로에 해당하는 파일의 압축을 풀어라
                // destination 어디에 풀어줄건데? path 도큐먼트 위치 // overwrite 같은 파일이 있다면 덮어쓸래?
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("압축 진행률 progress: \(progress)") // progress 압축에 대한 진행률
                }, fileOutputHandler: { unzippedFile in
                    print("압축 해제 완료: \(unzippedFile)")
                })
            } catch {
                print("압축 해제 실패")
            }
            
        } else {
            
            //경로에 복구할 파일이 없을 때의 대응
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL) // at 출발지, to 도착지
                
                let fileURL = path.appendingPathComponent("YeriArchive.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("압축 진행률 progress: \(progress)") // progress 압축에 대한 진행률
                }, fileOutputHandler: { unzippedFile in
                    print("압축 해제 완료: \(unzippedFile)")
                    
                    exit(0) // 앱 강제종료
                    
                 })
                
            } catch {
                print("압축 해제 실패")
            }
            
        }
        
        
        
    }
    
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func fetchZipList() -> [String] {
        var list: [String] = [] // 도큐먼트 폴더에 있는 압축 파일 목록이 담길 배열
        
        do {
            guard let path = documentDirectoryPath() else { return list } // 도큐먼트 경로를 가져옴
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil) // 모든 파일 목록
            let zip = docs.filter { $0.pathExtension == "zip" } // pathExtension : 가장 마지막에 구성된 확장자 이름
            for i in zip {
                list.append(i.lastPathComponent) // 마지막 슬러쉬 기준으로 뒤에 있는 값을 스트링으로 가져옴
                // 따라서 특정 확장자에 대한 파일만 보임
            }
        } catch {
            print("ERROR")
        }
        return list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let row = fetchZipList()[indexPath.row]
        cell.textLabel?.text = row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showActivityViewController(fileName: fetchZipList()[indexPath.row])
    }
    
    func showActivityViewController(fileName: String) {
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있어요")
            return
        }
        
        let backupFileURL = path.appendingPathComponent(fileName)
        // fileName 매개변수 넣기 전 : 어떤 셀을 선택할때마다 액션시트에서 같은 이름을 띄웠음
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: []) // 백업 파일 url 전달
        present(vc, animated: true)
    }
    
}
