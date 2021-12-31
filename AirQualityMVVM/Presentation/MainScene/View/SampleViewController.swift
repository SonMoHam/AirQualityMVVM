//
//  ViewController.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import UIKit
import RxSwift
import GoogleMaps
import CoreLocation
import MapKit

class SampleViewController: UIViewController {
    private var locationManager: CLLocationManager!
    private let mapMarker = GMSMarker()
    private var mapView: GMSMapView?
    
    private var sampleViewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    static func create(with viewModel: ViewModel) -> SampleViewController {
        let view = SampleViewController.init(nibName: "SampleViewController", bundle: nil)
        view.sampleViewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLocationManager()
        
        bind(to: sampleViewModel)
        
        //        initFetchButton()

        //        현재 위치 위, 경도 가져오기
        let coor = locationManager.location?.coordinate
        let latitude = (coor?.latitude ?? 37.566508) as Double
        let longitude = (coor?.longitude ?? 126.977945) as Double
        
        initMapView(latitude: latitude, longitude: longitude)
        // 마커 세팅
        mapMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapMarker.map = mapView
        
        // 타이틀, 스니펫 띄우기
        mapView?.selectedMarker = mapMarker
        self.view.addSubview(mapView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        
        //        sampleViewModel.sampleInput(latitude: "0", longitude: "0")
    }
    
    // MARK: - private methods
    
    @objc
    func onFetchButtonClicked() {
        sampleViewModel.sampleInput(latitude: "37.2099983215332", longitude: "127.01000213623047")
    }
    
    private func bind(to viewModel: ViewModel){
        viewModel.address.subscribe(onNext: { [weak self] in
            print("\nadress: \($0)")
            self?.mapMarker.title = String($0.split(separator: " ").last ?? "")
        }).disposed(by: disposeBag)
        
        viewModel.aqi.subscribe(onNext: { [weak self] in
            print("aqi: \($0)")
            self?.mapMarker.snippet = $0
        }).disposed(by: disposeBag)
    }
    
    private func initFetchButton(){
        let fetchButton = UIButton()
        
        self.view.addSubview(fetchButton)
        
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fetchButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        fetchButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        fetchButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        fetchButton.setTitle("fetch", for: .normal)
        fetchButton.setTitleColor(.black, for: .normal)
        fetchButton.backgroundColor = .orange
        fetchButton.addTarget(self, action: #selector(onFetchButtonClicked), for: .touchUpInside)
    }
    
    
    private func configLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // 앱이 실행될 때 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        // 배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        // 현재 위치 가져오기

    }
    
    private func initMapView(latitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height - 100) / 2 )
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        mapView?.delegate = self
    }
}

extension SampleViewController: CLLocationManagerDelegate {
    
}

extension SampleViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        mapMarker.position = position.target
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("\nidleAt: \(position)")
        let lat = mapMarker.position.latitude as Double
        let long = mapMarker.position.longitude as Double
        sampleViewModel.sampleInput(latitude: "\(lat)", longitude: "\(long)")
    }
}
