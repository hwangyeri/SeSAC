//
//  LocationViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/22.
//

import UIKit
import CoreLocation //1. 위치 import
import MapKit
import SnapKit

class LocationViewController: UIViewController {
    
    //2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    let cafeButton = UIButton()
    let foodButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
        }
        
        view.addSubview(cafeButton)
        cafeButton.backgroundColor = .systemBlue
        cafeButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.size.equalTo(50)
            make.leading.equalTo(view).offset(100)
        }
        cafeButton.addTarget(self, action: #selector(cafeButtonClicked), for: .touchUpInside)
        
        view.addSubview(foodButton)
        foodButton.backgroundColor = .systemMint
        foodButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.size.equalTo(50)
            make.trailing.equalTo(view).offset(-100)
        }

        view.backgroundColor = .white
        
        //3. 위치 프로토콜 연결
        locationManager.delegate = self
        
//        //Info.plist <<< 얼럿 // Info.plist 설정을 해야 뜸 => Privacy - Location When In Use Usage Description
//        locationManager.requestWhenInUseAuthorization()
        
        checkDeviceLocationAuthrization()
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        setRegionAndAnnotation(center: center)
        setAnnotation(type: 0)
    }
    
    
    @objc func cafeButtonClicked() {
        
        let num2 = Int.random(in: 1...100) //Scope
        
        setAnnotation(type: 1) // 1 >
        print("aaaaa")
    }
    
    func setAnnotation(type: Int) {
        //37.517746, 126.887131 오늘의 밥상
        //37.518594, 126.894798 문래역
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.517746, longitude: 126.887131)

        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.518594, longitude: 126.894798)
        
        if type == 0 { //viewDidLoad
            mapView.addAnnotations([annotation1, annotation2])
        } else if type == 1 {
            //mapView.removeAnnotation(annotation1) // 동작 X // Scope, 윗줄의 annotation1 과 다름
            mapView.removeAnnotations(mapView.annotations) // 동작 O
            mapView.addAnnotations([annotation2])
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) { // MapPin -> Annotation
        print("=========", #function)
        
        //지도 중심 기반으로 보여질 범위 설정
        //let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400) // 어디를 중심으로 보여줄지, 몇미터 기준으로 보여줄지
        mapView.setRegion(region, animated: true)
        
        //지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "영등포캠퍼스 입니다"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    func checkDeviceLocationAuthrization() {
        print("======", #function)
        
        //iOS 위치 서비스 활성화 체크
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() { // 아이폰 설정에서 위치 서비스에 대한 여부를 확인
                
                //현재 사용자의 위치 권한 상태를 가지고 옴
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                print("===== authorization =====", authorization)
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다")
            }
            
        }
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", status)
        
        // @frozen >> 컴파일 시점에 계산, 더이상 열거형에 절대 추가될 케이스가 없다고 확신한다!!!
        
        switch status {
        case .notDetermined: // 최초로 사용자가 앱을 켰을때 아무것도 결정되지 않은 상태 // 한 번 허용
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 각 기종에 맞게
            locationManager.requestWhenInUseAuthorization() // 얼럿 띄워주는 역할, Info.plist 설정헤야 뜸
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse: // 이미 권한이 허용된 상태
            print("authorizedWhenInUse")
            //didUpdateLocations 메서드 실행
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default: print("default") // 위치 권한 종류가 더 생길 가능성 대비
        }
        
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            // 설정에서 직접적으로 앱 설정 화면에 들어간 적이 없다면
            // 한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서
            // 설정 페이지로 넘어갈지, 설정 상세 페이지 결정 X
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                print("******", appSetting)
                UIApplication.shared.open(appSetting) // 설정 페이지로 이동, 나의 앱 - 지도 - 위치 페이지까지 갈 순 없음
            }
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
}

//4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    
    //5. 사용자의 위치를 성공적으로 가지고 온 경우
    //한번만 실행되지 않는다, iOS 위치 업데이트가 필요한 시점에 알아서 여러번 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // 새로운 위치가 생기면 알려줌
        print("=== locations ===", locations)
        
        if let coordinate = locations.last?.coordinate { // 위도 경도 값 가져오기
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)
            //날씨 API 호출
        }
        
        locationManager.stopUpdatingLocation() // 한번만 실행하고 싶을 때
    }
    
    //사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    //사용자 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정에서 변경을 했거나, 혹은 notDetermined 상태에서 허용을 했거나
    //허용해서 위히를 가지고 오는 도중에, 설정에서 거부를 하고 앱으올 다시 돌아올 떄 등
    //iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
    //사용자의 권한 상태가 바뀔 때를 알려줌
    //iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    
}

extension LocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("-----", #function)
    }

    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print("-----", #function)
    }

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print(#function)
//    }

}
