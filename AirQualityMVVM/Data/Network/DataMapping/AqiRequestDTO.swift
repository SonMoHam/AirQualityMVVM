//
//  AqiRequestDTO.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/15.
//

import Foundation

struct AqiRequestDTO: Encodable {
    let latitude: String
    let longitude: String
    let key: String
    init(latitude lat: String, longitude lng: String) {
        self.latitude = lat
        self.longitude = lng
        self.key = API.AIR_QUALITY_INDEX.TOKEN
    }
}
