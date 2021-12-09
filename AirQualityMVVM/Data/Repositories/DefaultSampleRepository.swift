//
//  DefaultSampleRepository.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

class DefaultSampleRepository: SampleRepository{
    public func fetchTest(latitude lat: String, longitude lng: String, completion: @escaping(_ entities: [Administrative]?) -> () )  {
        let sampleRequestDTO = SampleRequestDTO(latitude: lat, longitude: lng)
        let endpoint = APIEndpoints.getTest(with: sampleRequestDTO)
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
}
