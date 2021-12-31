//
//  SampleRepository.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

protocol SampleRepository {
    
    func fetchAdministratives(with requestDTO: ReverseGeocodeRequestDTO, completion: @escaping(_ entities: [Administrative]?) -> () )
    func fetchAirQualityIndex(with requestDTO: AqiRequestDTO, completion: @escaping(_ aqi: String) -> () )
}
