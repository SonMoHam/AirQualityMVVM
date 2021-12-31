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
        static let BASE_URL = "https://api.airvisual.com"
        static let TOKEN = "7fe4d2b6-8ead-470e-9a8d-79c5119a3c63"
        enum PATH {
            static let NEAREST_CITY = "/v2/nearest_city"
            static let NEAREST_STATION = "/v2/nearest_station"
        }
    }
    static let GMS_APIKEY = "AIzaSyCLVgcl4lkR5cgk36vs65QZzhi7qxzxTOw"
}
