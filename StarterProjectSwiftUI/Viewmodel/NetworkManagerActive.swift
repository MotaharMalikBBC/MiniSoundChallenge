import Foundation

@MainActor
class NetworkManagerActive: ObservableObject {
    @Published var user: ApiModel?
    @Published var isLoading = false

    func fetchAPIDetails(from endpoint: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            user = try await getAPIDetails(from: endpoint)  // Pass the endpoint dynamically
        } catch APIError.invalidData {
           print("Invalid data")
        } catch APIError.invalidResponse {
            print("Invalid response")
        } catch APIError.invalidURL {
            print("Invalid URL")
        } catch {
            print("An error occurred: \(error)")
        }
    }

    private func getAPIDetails(from endpoint: String) async throws -> ApiModel {
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
