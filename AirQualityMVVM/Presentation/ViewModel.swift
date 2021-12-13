//
//  ViewModel.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/13.
//

import Foundation

protocol ViewModelInput {
    func sampleInput()
}
protocol ViewModelOutput {
    func sampleOutput()
}
protocol ViewModel: ViewModelInput, ViewModelOutput { }

class DefaultViewModel: ViewModel {

    
    private let sampleUseCase: SampleUseCase
    
    init(sampleUseCase: SampleUseCase) {
        self.sampleUseCase = sampleUseCase
    }
    
    
    
    // MARK: - Output
    func sampleOutput() {
        
    }
    
    
    // MARK: - Private
    private func getAddressName(at coor: Coordinates) {
        sampleUseCase.getAdministratives(at: coor) { administratives in
            if administratives.count > 0 {
                print("count > 0")
            } else {
                print("none of contents")
            }
        }
    }
    
    
    // MARK: - Input, View event
    func sampleInput() {
        
    }
}
