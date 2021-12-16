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
        print("viewDidLoad")
        
        let a = PublishSubject<A>()
        let b = PublishSubject<B>()
        
        let observable = Observable.zip(a, b) { first, second -> C in
            return .init(name: "\(first.name) \(second.name)", idA: first.id, idB: second.id)
        }
        
        observable
//            .filter { $0.idA == $0.idB }
            .subscribe(onNext: {
                print($0)
        }).disposed(by: disposeBag)
        
        
        a.onNext(.init(name: "a_first", id: 1))
        b.onNext(.init(name: "b_first", id: 1))
        a.onNext(.init(name: "a_second", id: 2))
        a.onNext(.init(name: "a_third", id: 3))
        b.onNext(.init(name: "b_second", id: 2))
        b.onNext(.init(name: "b_third", id: 3))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
//        sampleViewModel.sampleInput(latitude: "37.5099983215332", longitude: "127.01000213623047")
//        sampleViewModel.sampleInput(latitude: "0", longitude: "0")
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

