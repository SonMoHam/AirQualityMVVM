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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleViewModel = makeSampleViewModel()
        bind(to: sampleViewModel)
        print("viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        sampleViewModel.sampleInput(latitude: "37.5099983215332", longitude: "127.01000213623047")
        sampleViewModel.sampleInput(latitude: "0", longitude: "0")
    }
    
    // MARK: - private methods
    
    private func bind(to viewModel: ViewModel){
        viewModel.result.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
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

