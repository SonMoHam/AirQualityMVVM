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
    var address: PublishSubject<String> { get }
    var aqi: PublishSubject<String> { get }
}
protocol ViewModel: ViewModelInput, ViewModelOutput { }

final class DefaultViewModel: ViewModel {

    
    private let sampleUseCase: SampleUseCase
    
    
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
            self.address.onNext(result)

        }
    }
    
    private func fetchAirQualityIndex(at coor: Coordinates) {
        sampleUseCase.getAirQualityIndex(at: coor) {
            self.aqi.onNext($0)
        }
    }
    
    private func fetchLocationInfo(at coor: Coordinates) {
        fetchAddressName(at: coor)
        fetchAirQualityIndex(at: coor)
    }
    
    // MARK: - Output
    
    let address = PublishSubject<String>()
    let aqi = PublishSubject<String>()
    
    // MARK: - Input, View event
    func sampleInput(latitude: String, longitude: String) {
        let coordinates: Coordinates = .init(latitude: latitude, longitude: longitude)
        fetchLocationInfo(at: coordinates)
    }
}
