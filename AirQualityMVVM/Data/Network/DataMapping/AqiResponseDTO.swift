//
//  AqiResponseDTO.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/15.
//

import Foundation

struct AqiResponseDTO: Decodable {
    let data: AqiData
}

struct AqiData: Decodable {
    let city: String
    let country: String
    let current: Current
}

struct Current: Decodable {
    let pollution: Pollution
}

struct Pollution: Decodable{
    let aqius: Int
}

extension AqiResponseDTO {
    func toString() -> String {
        return String(self.data.current.pollution.aqius)
    }
}
