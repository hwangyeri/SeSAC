//
//  AddViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit
import SeSACFramework

//Protocol 값 전달 1. // 부하직원 등록
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

// 1. 딜리게이트 구성
protocol PassImageDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    let picker = UIImagePickerController()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 X // 애플이 만들어둔거 말고 내가 만든 걸로 쓸게
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil) // addObserver는 신호만 받음, 신호 받았을때 뭐할지는 selector로 별도 구현
        
//        ClassOpenExample.publicExample()
//        ClassPublicExample.publicExample()
        
//        APIService.shared.callRequest(query: "sky")
    }
    
    deinit {
        // 메모리상 문제가 없는지, UI적으로만 사라진게 아니라 메모리에서도 없애고 공간을 차지하지 않도록 // 메모리 누수를 찾아볼 수 있는 방법
        // AddViewController 시작화면이기 때문에 메모리에 남아있음
        print("deinit", self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // 편집 상태 허가, ex. 찍은 사진 확대 가능
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("========", #function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        //sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
//        sesacShowAlert(title: <#T##String#>, message: <#T##String#>, buttonTitle: <#T##String#>, buttonAction: <#T##(UIAlertAction) -> Void#>)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("========", #function)
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }

    override func configureView() {
        super.configureView()
        print("Add configureView")
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside) // View Setting 환경설정과 관련됨
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("Add setConstraints")
    }
    
    @objc func searchButtonClicked() {
        print(#function)
        
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        // ActionSheet
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionGallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { // 쓸 수 있는지 확인
                print("갤러리 사용 불가, 사용자에게 토스트/얼럿") // 읽기 권한은 필요없음, 단순히 사진을 가져오는 것은 가능
                return
            }
            
            self.present(self.picker, animated: true)
        }
        
        let actionWeb = UIAlertAction(title: "웹에서 가져오기", style: .default) { _ in
            self.present(SearchViewController(), animated: true)
        }
        
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheetController.addAction(actionGallery)
        actionSheetController.addAction(actionWeb)
        actionSheetController.addAction(actionCancel)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @objc func dateButtonClicked() {
//        //Protocol 값 전달 5.
//        let vc = DateViewController()
//        vc.delegate = self // 너 부하직원 있지? 부하직원이 할 수 있는 일을 내가 대신 할게 ~
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        // 5.
        let vc = SearchViewController()
        vc.delegate = self
        
        present(vc, animated: true)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        //Closure - 3
        vc.completionHandler = { title, age, push  in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHandler", age, push)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func contentButtonClicked() {
        let vc = ContentViewController()
        
        vc.completionHandler = { text in // in 을 기준으로 헤더랑 내용?이 나뉨
            self.mainView.contentButton.setTitle(text, for: .normal)
            print("completionHandler")
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

//Protocol 값 전달 4. // 실제로 수행할 수 있는 요소
extension AddViewController: PassDataDelegate {
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    // 4.
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print(#function)
    }
    
    //사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // 크롭한 이미지로 저장하려면 editedImage
            mainView.photoImageView.image = image
            dismiss(animated: true)
        }
    }
    
    
}
