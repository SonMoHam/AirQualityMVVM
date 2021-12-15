//
//  APIEndpoints.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

struct APIEndpoints {
    static private let headers = ["Content-Type": "application/json"]
    static func getTest(with sampleRequestDTO: SampleRequestDTO) -> Endpoint<SampleResponseDTO> {
        return Endpoint(baseURL: API.REVERSE_GEOCODE.BASE_URL,
                        path: API.REVERSE_GEOCODE.PATH,
                        method: .get,
                        queryParameters: sampleRequestDTO,
                        headers: headers)
    }
    
    static func getAQI(with aqiRequestDTO: AqiRequestDTO) -> Endpoint<AqiResponseDTO> {
        return Endpoint(baseURL: API.AIR_QUALITY_INDEX.BASE_URL,
                        path: API.AIR_QUALITY_INDEX.PATH + ":\("latitude");\("longitude")/?token=\(API.AIR_QUALITY_INDEX.TOKEN)",
                        method: .get,
                        headers: headers)
    }
}
