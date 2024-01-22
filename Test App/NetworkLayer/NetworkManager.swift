//
//  NetworkManager.swift
//  Test App
//
//  Created by Aijaz Ali on 22/01/2024.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func get<T: Decodable>(url: String, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .get, modelType: modelType, completion: completion)
    }
    
    func post<T: Decodable>(url: String, modelType: T.Type, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .post, modelType: modelType, parameters: parameters, encoding: encoding, headers: headers, completion: completion)
    }
    
    func put<T: Decodable>(url: String, modelType: T.Type, parameters: [String: Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .put, modelType: modelType, parameters: parameters, encoding: encoding, headers: headers, completion: completion)
    }
    
    func delete<T: Decodable>(url: String, modelType: T.Type, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .delete, modelType: modelType, headers: headers, completion: completion)
    }
    
    private func performRequest<T: Decodable>(url: String, method: HTTPMethod, modelType: T.Type, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping (Result<T, Error>) -> Void) {
        var customHeaders = headers ?? [:]
        if let token = UserDefaults.standard.object(forKey: "userToken") as? String {
            // Get your authorization token from a secure source, e.g., keychain
            customHeaders["Authorization"] = "Bearer \(token)"
        }
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: customHeaders)
            .validate()
            .responseDecodable(of: modelType) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


enum API: Error {
    case URLGenerationError
    case HTTPBadRequestError
}
