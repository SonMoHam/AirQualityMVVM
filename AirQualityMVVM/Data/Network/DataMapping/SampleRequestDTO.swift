//
//  SampleRequestDTO.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

struct SampleRequestDTO: Encodable {
    let latitude: String
    let longitude: String
    let localityLanguage: String
    init(latitude lat: String, longitude lng: String, localityLanguage: String = "ko") {
        self.latitude = lat
        self.longitude = lng
        self.localityLanguage = localityLanguage
    }
}
