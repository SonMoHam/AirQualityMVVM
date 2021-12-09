//
//  Endpoint.swift
//  AirQualityMVVM
//
//  Created by 코액터스 on 2021/12/07.
//

import Foundation
import Alamofire

enum RequestGenerationError: Error {
    case components
}

public enum HTTPMethodType: String {
    case get    = "GET"
    case head   = "HEAD"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

class Endpoint<R>: ResponseRequestable {
    typealias Response = R
    
    var baseURL: String
    var path: String
    var method: HTTPMethodType
    var queryParameters: Encodable?
    var bodyParameters: Encodable?
    var headers: [String: String]?
    
    init(baseURL: String,
         path: String = "",
         method: HTTPMethodType,
         queryParameters: Encodable? = nil,
         bodyParameters: Encodable? = nil,
         headers: [String: String]? = [:]
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
}

public protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    //    var responseDecoder: ResponseDecoder { get }
}
extension Requestable {
    func url() throws -> URL{
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else {
            print("urlComponets")
            throw RequestGenerationError.components
        }
        var urlQueryItems: [URLQueryItem] = []
        if let queryParams = try queryParameters?.toDictionary() {
            queryParams.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else {
            print("url")
            throw RequestGenerationError.components
        }
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)
        
        if let bodyParams = try bodyParameters?.toDictionary() {
            if !bodyParams.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams)
            }
        }
        urlRequest.httpMethod = method.rawValue
        headers?.forEach({ (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        return urlRequest
    }
}



private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
