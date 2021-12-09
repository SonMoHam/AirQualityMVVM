//
//  NetworkService.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation
import Alamofire
class NetworkService {
    static let shared = NetworkService()
    
    func testRequest<R: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping(Result<R, Error>) -> () ) where E.Response == R {
        do {
            let urlRequest = try endpoint.asURLRequest()
            AF.request(urlRequest).responseJSON { [weak self] response in
                switch response.result {
                
                case .success(_):

                        completion((self?.decode(data: response.data))!)
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        } catch {
            print("NetworkService catch")
            completion(.failure(RequestGenerationError.components))
        }
    }
    
    private func decode<R: Decodable>(data: Data?) -> Result<R, Error> {
        do {
            guard let data = data else { return .failure(AFError.explicitlyCancelled)}
            
            print(R.self)
            let decoded: R = try JSONDecoder().decode(R.self, from: data)
            return .success(decoded)
        } catch {
            
            return .failure(AFError.sessionDeinitialized)
        }
    }
}
