//
//  LocationViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/22.
//

import UIKit
import CoreLocation //1. 위치 import

class LocationViewController: UIViewController {
    
    //2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        //3. 위치 프로토콜 연결
        locationManager.delegate = self
        
//        //Info.plist <<< 얼럿 // Info.plist 설정을 해야 뜸 => Privacy - Location When In Use Usage Description
//        locationManager.requestWhenInUseAuthorization()
        
        checkDeviceLocationAuthrization()
    }
    
    func checkDeviceLocationAuthrization() {
        
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
                
                print(authorization)
                self.checkCurrentLocationAuthorization(status: authorization)
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다")
            }
            
        }
        
        
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        
        print("check", status)
        switch status {
        case .notDetermined: // 최초로 사용자가 앱을 켰을때 아무것도 결정되지 않은 상태
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 각 기종에 맞게
            locationManager.requestWhenInUseAuthorization() // 다이얼로그 띄워주는 역할
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpdateLocations 메서드 실행
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        }
        
    }
    
    
    
}

//4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    
    //5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // 새로운 위치가 생기면 알려줌
        print("=====", locations)
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
