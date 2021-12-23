//
//  ViewController.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    struct A {
        let name: String
        let id: Int
    }
    struct B {
        let name: String
        let id: Int
    }
    struct C {
        let name: String
        let idA: Int
        let idB: Int
    }
    private var sampleViewModel: ViewModel!
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleViewModel = makeSampleViewModel()
        bind(to: sampleViewModel)
        
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
            print("adress: \($0)")
        }).disposed(by: disposeBag)
        
        viewModel.aqi.subscribe(onNext: {
            print("aqi: \($0)")
        }).disposed(by: disposeBag)
    }
    
    @objc
    func onFetchButtonClicked() {
        sampleViewModel.sampleInput(latitude: "37.2099983215332", longitude: "127.01000213623047")
//        sampleViewModel.sampleInput(latitude: "35.5099983215332", longitude: "119.01000213623047")
    }
    // MARK: - factory methods, 이동 예정
    
    private func makeSampleViewModel() -> ViewModel {
        return DefaultViewModel(sampleUseCase: makeSampleUseCase())
    }
    
    private func makeSampleUseCase() -> SampleUseCase {
        return DefaultSampleUseCase(sampleRepository: makeSampleRepository())
    }
    
    private func makeSampleRepository() -> SampleRepository {
        return DefaultSampleRepository()
    }

}

