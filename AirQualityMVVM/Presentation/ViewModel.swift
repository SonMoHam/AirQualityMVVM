//
//  ViewModel.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/13.
//

import Foundation
import RxSwift

protocol ViewModelInput {
    func sampleInput(latitude: String, longitude: String)
}
protocol ViewModelOutput {
    var result: PublishSubject<String> { get }
}
protocol ViewModel: ViewModelInput, ViewModelOutput { }

class DefaultViewModel: ViewModel {

    
    private let sampleUseCase: SampleUseCase
    
    init(sampleUseCase: SampleUseCase) {
        self.sampleUseCase = sampleUseCase
    }
    
    
    
    // MARK: - Output
    let result = PublishSubject<String>()
    
    
    // MARK: - Private
    private func testGetAddressName(at coor: Coordinates) {
        sampleUseCase.getAdministratives(at: coor) { administratives in
            var result: String = ""
            if administratives.count > 0 {
                administratives.forEach {
                    result = result + " " + $0.name
                }
            } else {
                result = "none of contents"
            }
            self.result.onNext(result)
        }
    }
    
    
    // MARK: - Input, View event
    func sampleInput(latitude: String, longitude: String) {
        let coordinates: Coordinates = .init(latitude: latitude, longitude: longitude)
        testGetAddressName(at: coordinates)
    }
}
