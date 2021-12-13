//
//  SampleUseCase.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

protocol SampleUseCase {
    func getAdministratives(at: Coordinates, completion: @escaping([Administrative]) -> ())
    func getAirQualityIndex(at: Coordinates, completion: @escaping(String) -> ())
}

class DefaultSampleUseCase: SampleUseCase {

    
    
    private let sampleRepository: SampleRepository
    
    init(sampleRepository: SampleRepository) {
        self.sampleRepository = sampleRepository
    }
    
    
    func getAdministratives(at: Coordinates, completion: @escaping ([Administrative]) -> ()) {
        
        sampleRepository.fetchTest(latitude: at.latitude, longitude: at.longitude) { administratives in
            let result: [Administrative] = administratives ?? []
            completion(result)
        }
    }
    
    func getAirQualityIndex(at: Coordinates, completion: @escaping (String) -> ()) {
        //
    }
}
