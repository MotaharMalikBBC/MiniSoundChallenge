//
//  ObservableObject.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 14/09/2024.
//

import Foundation
import SwiftUI
import Combine

class Order: ObservableObject {
    // Your properties and methods
    @Published var itemCount: Int = 0
}
