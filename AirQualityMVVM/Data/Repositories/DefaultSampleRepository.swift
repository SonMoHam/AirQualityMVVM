//
//  DefaultSampleRepository.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

class DefaultSampleRepository: SampleRepository{
    public func fetchTest(with requestDTO: SampleRequestDTO, completion: @escaping(_ entities: [Administrative]?) -> () )  {
        
        let endpoint = APIEndpoints.getTest(with: requestDTO)
        NetworkService.shared.testRequest(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(response.toDomain())
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    public func fetchAirQualityIndex(with requestDTO: AqiRequestDTO, completion: @escaping (String) -> ()) {
        let endpoint = APIEndpoints.getAQI(with: requestDTO)
        NetworkService.shared.testRequest(with: endpoint) { result in
            print(result)
            switch result {
            case .success(let response):
                completion(response.toString())
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
