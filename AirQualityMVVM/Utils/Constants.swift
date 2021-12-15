//
//  Constants.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/09.
//

import Foundation

enum API {
    enum REVERSE_GEOCODE {
        static let BASE_URL = "https://api.bigdatacloud.net"
        static let PATH = "/data/reverse-geocode-client"
    }
    
    enum AIR_QUALITY_INDEX {
        static let BASE_URL = "https://api.waqi.info"
        static let PATH = "/feed/geo"
        static let TOKEN = "809ef3190596db15041a647ed0db24c5deb874e3"
    }
}
