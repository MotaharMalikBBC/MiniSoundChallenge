//
//  MainView.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 14/09/2024.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        TabView {
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                       
                }
            ContentViewAPI(endpoint: Constants.endpointActive)
                .tabItem {
                    Label("Music", systemImage: "play.circle")
                }
            Text("this is the my sounds tabr bar ")
                .tabItem {
                    Label("My sound", systemImage :"folder.fill")
                }
            Text("this is the search tabr bar ")
                .tabItem {
                    Label("Search", systemImage :"magnifyingglass")
                }
            Text("this is the debug tabr bar ")
                .tabItem {
                    Label("Debug", systemImage :"wrench.and.screwdriver.fill")
                }

        }.tint(.red)
    }
}

#Preview {
    MainView()
        .environmentObject(Order())
}
