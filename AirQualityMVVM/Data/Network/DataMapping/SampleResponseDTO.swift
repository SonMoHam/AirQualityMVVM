//
//  SampleResponseDTO.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation

struct SampleResponseDTO: Decodable {
    let localityInfo: LocalityInfoDTO
    
    struct LocalityInfoDTO: Decodable {
        let administrative: [AdministrativeDTO]
        
        struct AdministrativeDTO: Decodable {
            let order: Int
            let adminLevel: Int
            let name: String
        }
    }
}

extension SampleResponseDTO {
    func toDomain() -> [Administrative] {
        var result: [Administrative] = []
        localityInfo.administrative.forEach { dto in
            result.append(.init(order: dto.order, adminLevel: dto.adminLevel, name: dto.name))
        }
        return result
    }
}
