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
        
        let leftButton = UIBarButtonItem(title: "Main", style: .plain, target: self, action: #selector(backButton))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "chevron.left")

        let rightButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButton))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
        
        checkDeviceLocationAuthrization()
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) // 새싹 영등포 캠퍼스
        setRegionAndAnnotation(center: center)
        setAnnotation(type: 0)
    }
    
    @objc func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterButton() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.setAnnotation(type: 3)
        })
        actionSheet.addAction(UIAlertAction(title: "메가박스", style: .default) { _ in
            self.setAnnotation(type: 2)
        })
        actionSheet.addAction(UIAlertAction(title: "CGV", style: .default) { _ in
            self.setAnnotation(type: 1)
        })
        actionSheet.addAction(UIAlertAction(title: "전체보기", style: .default) { _ in
            self.setAnnotation(type: 0)
        })
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setAnnotation(type: Int) {
        let theaterListIndex = theaterList.mapAnnotations
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[0].latitude, longitude: theaterListIndex[0].longitude)

        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[1].latitude, longitude: theaterListIndex[1].longitude)
        
        let annotation3 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[2].latitude, longitude: theaterListIndex[2].longitude)
        
        let annotation4 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[3].latitude, longitude: theaterListIndex[3].longitude)
        
        let annotation5 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[4].latitude, longitude: theaterListIndex[4].longitude)
        
        let annotation6 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[5].latitude, longitude: theaterListIndex[5].longitude)
        
        let annotationList = [annotation1, annotation2, annotation3, annotation4, annotation5, annotation6]
        
        if type == 0 { // 전체보기
            mapView.addAnnotations(annotationList)
        } else if type == 1 { // CGV
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation5, annotation6])
        } else if type == 2 {  // 메가박스
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation3, annotation4])
        } else if type == 3 { // 롯데시네마
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation1, annotation2])
        }
        
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
