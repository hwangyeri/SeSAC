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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        locationManager.delegate = self

        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view).inset(100)
            make.horizontalEdges.equalTo(view).inset(10)
        }
        
        let leftButton = UIBarButtonItem(title: "Main", style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "chevron.left")

        let rightButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
        
        checkDeviceLocationAuthrization()
        
        let sesacCenter = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) // 새싹 영등포 캠퍼스
        setRegionAndAnnotation(center: sesacCenter)
//        let center = CLLocationCoordinate2D
//        setRegionAndAnnotation(center: center)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterButtonClicked() { // Filter 버튼 클릭 시 Alert Present
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
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
    
    func filterAnnotation(keyword: String) { // MapView Annotation Filter 기능
        
        mapView.removeAnnotations(mapView.annotations)
        
        let value = keyword == "전체보기" ? theaterList.mapAnnotations : theaterList.mapAnnotations.filter { $0.type == keyword }
        
        value.forEach { item in
            setAnnotation(latitude: item.latitude, longitude: item.longitude, title: item.type)
        }
    }
    
    func setAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) { // MapView Annotation Add 기능
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        print("--- annotations ---", mapView.annotations)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        print("==== Region =====", #function)

        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.title = "나의 현재 위치"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    func checkDeviceLocationAuthrization() {
        print("======", #function)
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
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
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("=== 사용자 위치 가져오기 성공, 새로운 위치가 생기면 알려줌 ===", locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("=== 사용자 위치 가져오기 실패 ===", error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    
}

extension TheaterViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("-----", #function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print("-----", #function)
    }
    
    
}
