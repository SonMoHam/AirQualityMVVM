//
//  APIEndpoints.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

struct APIEndpoints {
    static func getTest(with sampleRequestDTO: SampleRequestDTO) -> Endpoint<SampleResponseDTO> {
        return Endpoint(baseURL: API.REVERSE_GEOCODE.BASE_URL,
                        path: API.REVERSE_GEOCODE.PATH,
                        method: .get,
                        queryParameters: sampleRequestDTO,
                        headers: ["Content-Type": "application/json"] )
    }
}
