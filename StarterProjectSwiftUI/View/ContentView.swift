//
//  ContentView.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 05/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    
                    Text(networkManager.user?.status.message ?? "HOLDER: Unfortunately this version of the app no longer works. You'll need to update it to continue.")
                    Button(action: {
                        if let url = URL(string: networkManager.user?.status.appStoreURL ?? Constants.url) {
                            UIApplication.shared.open(url)
                        }
                    })
                    {
                        Text(networkManager.user?.status.linkTitle ?? "HOLDER: Update now")
                    }
                    
                    GroupBox {
                        RMSConfigBox(user: networkManager.user)
                    } label: {
                        Label("RMS Configuration", systemImage: "key.fill")
                    }
                }
                .navigationTitle(networkManager.user?.status.title ?? "HOLDER: it's time to update BBC Sounds")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .task {
                    await networkManager.fetchAPIDetails() 
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
