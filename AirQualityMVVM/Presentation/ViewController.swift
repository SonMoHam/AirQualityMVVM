//
//  ViewController.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    private var sampleViewModel: ViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle
    
    static func create(with viewModel: ViewModel) -> ViewController {
        let filename = ""
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: filename) as? Self else {
            fatalError("\(filename) ViewController 생성 실패")
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleViewModel = makeSampleViewModel()
        bind(to: sampleViewModel)

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

