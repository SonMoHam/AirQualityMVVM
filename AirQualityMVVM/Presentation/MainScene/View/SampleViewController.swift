//
//  ViewController.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import UIKit
import RxSwift

class SampleViewController: UIViewController {
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
        
        bind(to: sampleViewModel)
        initFetchButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        
//        sampleViewModel.sampleInput(latitude: "0", longitude: "0")
    }
    
    // MARK: - private methods
    
    private func bind(to viewModel: ViewModel){
        viewModel.address.subscribe(onNext: {
            print("\nadress: \($0)")
        }).disposed(by: disposeBag)
        
        viewModel.aqi.subscribe(onNext: {
            print("aqi: \($0)")
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
    
    @objc
    func onFetchButtonClicked() {
        sampleViewModel.sampleInput(latitude: "37.2099983215332", longitude: "127.01000213623047")
    }


}

