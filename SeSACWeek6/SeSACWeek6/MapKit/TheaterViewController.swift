//
//  TheaterViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class TheaterViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    let theaterList = TheaterList()
    
    // 나의 현재 위치로 이동하는 버튼
    let myLocationButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .systemMint
        button.contentMode = .scaleToFill
        var config = UIButton.Configuration.filled()
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        setNavigationButton()
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthrization()
        filterAnnotation(keyword: "전체보기")
        
        myLocationButton.addTarget(self, action: #selector(myLocationButtonClicked), for: .touchUpInside)
    }
    
    @objc func myLocationButtonClicked() {
        print("---------", #function)
        if let coordinate = locationManager.location?.coordinate {
            mapView.removeAnnotations(mapView.annotations)
            setRegionAndAnnotation(center: coordinate)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterButtonClicked() { // Filter 버튼 클릭 시 Alert Present
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 각 영화관 타입에 따른 필터링 옵션
        let actionLotteCinema = UIAlertAction(title: "롯데 시네마", style: .default) { _ in
            self.filterAnnotation(keyword: "롯데시네마")
        }
        let actionMegaBox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.filterAnnotation(keyword: "메가박스")
        }
        let actionCGV = UIAlertAction(title: "CGV", style: .default) { _ in
            self.filterAnnotation(keyword: "CGV")
        }
        let actionShowAll = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.filterAnnotation(keyword: "전체보기")
        }
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheetController.addAction(actionLotteCinema)
        actionSheetController.addAction(actionMegaBox)
        actionSheetController.addAction(actionCGV)
        actionSheetController.addAction(actionShowAll)
        actionSheetController.addAction(actionCancel)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(myLocationButton)
    }
    
    func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view).inset(100)
            make.horizontalEdges.equalTo(view).inset(10)
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(mapView)
        }
    }
    
    func setNavigationButton() {
        let leftButton = UIBarButtonItem(title: "Main", style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "chevron.left")
        
        let rightButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
    }
    
    // 영화관 정보를 필터링하여 지도에 표시
    func filterAnnotation(keyword: String) { // MapView Annotation Filter 기능
        mapView.removeAnnotations(mapView.annotations)
        
        // 선택한 필터링 옵션에 따라 영화관 정보 필터링 후 어노테이션 추가
        let value = keyword == "전체보기"
        ? theaterList.mapAnnotations
        : theaterList.mapAnnotations.filter { $0.type == keyword }
        
        value.forEach { item in
            setAnnotation(latitude: item.latitude, longitude: item.longitude, title: item.type)
        }
        
        // 어노테이션의 위치에 맞게 지도 영역 조정
        if let firstAnnotation = value.first {
            var minLatitude = firstAnnotation.latitude
            var maxLatitude = firstAnnotation.latitude
            var minLongitude = firstAnnotation.longitude
            var maxLongitude = firstAnnotation.longitude
            
            for annotation in value {
                minLatitude = min(minLatitude, annotation.latitude)
                maxLatitude = max(maxLatitude, annotation.latitude)
                minLongitude = min(minLongitude, annotation.longitude)
                maxLongitude = max(maxLongitude, annotation.longitude)
            }
            
            let centerLatitude = (maxLatitude + minLatitude) / 2
            let centerLongitude = (maxLongitude + minLongitude) / 2
            let latitudeDelta = max(maxLatitude - minLatitude, 0.05)
            let longitudeDelta = max(maxLongitude - minLongitude, 0.05)
            
            let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
            let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            let region = MKCoordinateRegion(center: center, span: span)
            
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    // MapView Annotation Add 맵뷰에 어노테이션을 추가
    func setAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    // 지도 중심 위치와 어노테이션 설정
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        print("==== 영역 설정 및 어노테이션 추가 ====", #function)

        let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "나의 현재 위치"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    // 디바이스의 위치 권한 상태 확인 및 초기 필터링 설정
    func checkDeviceLocationAuthrization() {
        print("======", #function)
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                // 위치 권한 상태 확인
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
    
    // 현재 위치 권한 상태에 따라 처리하는 메서드
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", status)
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
            let sesacCenter = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) // 새싹 영등포 캠퍼스
            setRegionAndAnnotation(center: sesacCenter)
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default: print("default")
        }
        
    }
    
    // 위치 서비스 활성화 안내 경고창을 표시하는 메서드
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                print("******", appSetting)
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
}

extension TheaterViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // 위치 업데이트 시 호출
        print("=== 사용자 위치 가져오기 성공, 새로운 위치가 생기면 알려줌 ===", locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setAnnotation(latitude: coordinate.latitude, longitude: coordinate.longitude, title: "나의 현재 위치") // Cannot find 'setAnnotation' in scope
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // 위치 업데이트 실패 시 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("=== 사용자 위치 가져오기 실패 ===", error)
    }
    
    // 위치 권한 상태 변경 시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
    // 위치 권한 상태 변경 시 호출 (iOS 14 이전)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    
}

extension TheaterViewController: MKMapViewDelegate {
    
    // 지도 영역이 변경될 때 호출
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("-----", #function)
    }
    
    // 어노테이션 선택 시 호출
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print("-----", #function)
    }
    
    
}
