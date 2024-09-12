import Foundation

@MainActor
class NetworkManagerActive: ObservableObject {
//    @Published var user: ApiModel?
    @Published var isLoading = false

    func fetchAPIDetails<T: Decodable>(from endpoint: String) async -> Result <T, APIError> {
        isLoading = true
        defer { isLoading = false }

        do {
            let data = try await getAPIDetails(from: endpoint)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData =  try decoder.decode(T.self, from: data)
            return .success(decodedData)
            
        } catch APIError.invalidData {
           print("Invalid data")
            return .failure(.invalidData)
        } catch APIError.invalidResponse {
            print("Invalid response")
            return .failure(.invalidResponse)
        } catch APIError.invalidURL {
            print("Invalid URL")
            return .failure(.invalidURL)
        } catch {
            print("An error occurred: \(error)")
            return .failure(.error)

        }
        
    }

    private func getAPIDetails(from endpoint: String) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
       return data
    }
    
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case error
    }
}


