//
//  DefaultSampleRepository.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

class DefaultSampleRepository: SampleRepository{
    public func fetchAdministratives(with requestDTO: ReverseGeocodeRequestDTO, completion: @escaping(_ entities: [Administrative]?) -> () )  {
        let endpoint = APIEndpoints.getReverseGeocode(with: requestDTO)
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
        let endpoint = APIEndpoints.getNearestCityAQI(with: requestDTO)
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
