//
//  NetworkService.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 19/09/2024.
//

import Foundation
class NetworkService {
  func fetchRMSData(completion: @escaping (Result<RMSEndpoint, APIError>) -> Void) {
    guard let url = URL(string: Constants.rmsEndpoint) else {
      completion(.failure(.invalidURL))
      return
    }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Error: \(error)")
        completion(.failure(.error))
        return
      }
      guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        completion(.failure(.invalidResponse))
        return
      }
      do {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode(RMSEndpoint.self, from: data)
        completion(.success(decodedData))
      } catch {
        print("Decoding error: \(error)")
        completion(.failure(.invalidData))
      }
    }
    task.resume()
  }
  enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case error
  }
}
