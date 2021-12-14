//
//  SampleRepository.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

protocol SampleRepository {
    
    func fetchTest(with requestDTO: SampleRequestDTO, completion: @escaping(_ entities: [Administrative]?) -> () )
}
