//
//  SampleRepository.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

protocol SampleRepository {
    
    func fetchTest(latitude lat: String, longitude lng: String, completion: @escaping(_ entities: [Administrative]?) -> () )
}
