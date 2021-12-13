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


struct Location {
    let coordinates: Coordinates
    var info: Info? = nil
    
    struct Info {
        var administratives: [Administrative]? = nil
        var AQI: String? = nil
    }
}
