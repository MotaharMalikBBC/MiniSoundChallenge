//
//  LoadingScreen.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 09/09/2024.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var didTap = false
    @State private var isActive = false
    @State private var isKill = false
    var body: some View {
        NavigationStack {
            VStack{
                AsyncImage(url: URL(string: Constants.bbbcSoundsImage)) { image in
                    image.resizable()
                } placeholder: {
                    Color.white
                }
                .frame(width: 300, height: 300)
                .clipShape(.rect(cornerRadius: 25))
                HStack{
                        Button(action: {
                            self.didTap = true
                            self.isActive = true
                        }, label: {
                            Text("active")
                                .frame(width: 100, height: 30, alignment: .center)
                                .padding()
                                .border(Color.black)
                                .bold()
                                .background(didTap ? Color.green : Color.yellow)
                        })
                    Button(action: {
                        self.didTap = true
                        self.isKill = true
                    }, label: {
                         Text("Kill switch")
                             .frame(width: 100, height: 30, alignment: .center)
                             .padding()
                             .border(Color.black)
                             .bold()
                             
                     })
                }
            }
                .navigationTitle("Kill switch page")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(isPresented: $isActive) {
                    ContentViewActive()
                }
                .navigationDestination(isPresented: $isKill) {
                    ContentViewKill()
                }
            
                

        }
    }
}

#Preview {
    LoadingScreen()
}
