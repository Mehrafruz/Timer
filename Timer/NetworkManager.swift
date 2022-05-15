//
//  NetworkManager.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case emptyData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalid url!!"
        case .emptyData:
            return "no data!!"
        }
    }
}

protocol NetworkManagerDescription: AnyObject {
    func currentTimer (completion: @escaping (Result<TimerModel, Error>) -> Void)
}

final class NetworkManager: NetworkManagerDescription {
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
    func currentTimer (completion: @escaping (Result<TimerModel, Error>) -> Void) {
        
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: path)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let currentTimer = try decoder.decode(TimerModel.self, from: data)
                completion(.success(currentTimer))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
