//
//  NetworkManager.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 06/09/2024.
//
//  NetworkManager.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 06/09/2024.
//

import Foundation


@MainActor
class NetworkManagerActive: ObservableObject {
    @Published var user: ApiModel?
    @Published var isLoading = false

    func fetchAPIDetails() async {
        isLoading = true
        defer { isLoading = false }

        do {
            user = try await getAPIDetails()
        } catch APIError.invalidData {
           print("invalid data")
        } catch APIError.invalidResponse {
            print("Invalid response")
        } catch APIError.invalidURL {
            print("invalid url")
        } catch {
            print("An error occurred: \(error)")
        }
    }

    private func getAPIDetails() async throws -> ApiModel {
        let endpoint = Constants.endpointActive
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(ApiModel.self, from: data)
    }
}

// Custom errors for the API
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

