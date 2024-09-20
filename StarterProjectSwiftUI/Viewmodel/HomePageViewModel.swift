//
//  HomePageViewModel.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 19/09/2024.
//

import Foundation
import SwiftUI
//@MainActor
class HomePageViewModel: ObservableObject {
  @Published var user: [InlineDisplayModule] = []
  @Published var isLoading = false
  @Published var errorMessage: String?
  private let networkService = NetworkService()
  func fetchData() {
    isLoading = true
    networkService.fetchRMSData { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success(let userModel):
          if let nationalAndRegionalStations = userModel.data.first(where: {$0.id == "national_and_regional_stations" }) {
            self?.user = [nationalAndRegionalStations]
          } else {
            self?.errorMessage = "No data available for national and regional stations."
          }
        case .failure(let error):
          self?.errorMessage = "Error fetching data: \(error)"
          print("Error: \(error)")
        }
      }
    }
  }
}
