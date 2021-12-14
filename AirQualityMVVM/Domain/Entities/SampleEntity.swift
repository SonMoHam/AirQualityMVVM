//
//  SampleEntity.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

struct Administrative {
    let order: Int
    let adminLevel: Int
    let name: String
}

struct Coordinates {
    let latitude: String
    let longitude: String
}


struct LocationInfo {
    let coordinates: Coordinates
    var name: String? = nil
    var AQI: String? = nil
}
