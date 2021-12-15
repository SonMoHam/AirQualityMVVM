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

final class DefaultViewModel: ViewModel {

    
    private let sampleUseCase: SampleUseCase
    private let address = PublishSubject<String>()
    private let aqi = PublishSubject<String>()
    
    init(sampleUseCase: SampleUseCase) {
        self.sampleUseCase = sampleUseCase
    }
    
    // MARK: - Private
    private func fetchAddressName(at coor: Coordinates) {
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
    
    private func fetchAirQualityIndex(at coor: Coordinates) {
        sampleUseCase.getAirQualityIndex(at: coor) {
            print($0)
        }
    }
    
    private func fetchLocationInfo(at coor: Coordinates) {
        fetchAddressName(at: coor)
        fetchAirQualityIndex(at: coor)
    }
    
    // MARK: - Output
    let result = PublishSubject<String>()
    
    
    // MARK: - Input, View event
    func sampleInput(latitude: String, longitude: String) {
        let coordinates: Coordinates = .init(latitude: latitude, longitude: longitude)
        fetchLocationInfo(at: coordinates)
    }
}
