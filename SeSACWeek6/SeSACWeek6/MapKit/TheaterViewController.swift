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
        
        let center = CLLocationCoordinate2D(latitude: 37.481250, longitude: 126.952709)
        setRegionAndAnnotation(center: center)
        setAnnotation(type: 0)
    }
    
    @objc func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterButton() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "메가박스", style: .default) { _ in
            self.filterMapPins(filterType: 1)
        })
        actionSheet.addAction(UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.filterMapPins(filterType: 2)
        })
        actionSheet.addAction(UIAlertAction(title: "CGV", style: .default) { _ in
            self.filterMapPins(filterType: 3)
        })
        actionSheet.addAction(UIAlertAction(title: "전체보기", style: .default) { _ in
            self.filterMapPins(filterType: 0)
        })
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func filterMapPins(filterType: Int) {
        mapView.removeAnnotations(mapView.annotations)
        
        switch filterType {
        case 0: // 전체보기
            setAnnotation(type: 0)
        case 1: // 메가박스
            setAnnotation(type: 1)
        case 2: // 롯데시네마
            setAnnotation(type: 2)
        case 3: // CGV
            setAnnotation(type: 3)
        default:
            break
        }
    }
    
    func setAnnotation(type: Int) {
        let theaterListIndex = theaterList.mapAnnotations
        
        var annotations: [MKPointAnnotation] = []

        for index in theaterListIndex.indices {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: theaterListIndex[index].latitude, longitude: theaterListIndex[index].longitude)
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        print("-----", mapView.annotations)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        print("=========", #function)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "우리집"
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
        print("=== locations ===", locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
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
