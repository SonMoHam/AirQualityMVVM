//
//  ViewController.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import UIKit

class ViewController: UIViewController {

    private let sampleRepository: SampleRepository = DefaultSampleRepository()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        sampleRepository.fetchTest(latitude: "37.5099983215332", longitude: "127.01000213623047") {
            print($0 ?? "")
        }
    }

}

