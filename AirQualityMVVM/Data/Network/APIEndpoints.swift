//
//  APIEndpoints.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

struct APIEndpoints {
    static private let headers = ["Content-Type": "application/json"]
    static func getReverseGeocode(with sampleRequestDTO: ReverseGeocodeRequestDTO) -> Endpoint<ReverseGeocodeResponseDTO> {
        return Endpoint(baseURL: API.REVERSE_GEOCODE.BASE_URL,
                        path: API.REVERSE_GEOCODE.PATH,
                        method: .get,
                        queryParameters: sampleRequestDTO,
                        headers: headers)
    }
    // http://api.airvisual.com/v2/nearest_city?lat={{LATITUDE}}&lon={{LONGITUDE}}&key={{YOUR_API_KEY}}
    static func getNearestCityAQI(with aqiRequestDTO: AqiRequestDTO) -> Endpoint<AqiResponseDTO> {
        return Endpoint(baseURL: API.AIR_QUALITY_INDEX.BASE_URL,
                        path: API.AIR_QUALITY_INDEX.PATH.NEAREST_CITY,
                        method: .get,
                        queryParameters: aqiRequestDTO,
                        headers: headers)
    }
}
