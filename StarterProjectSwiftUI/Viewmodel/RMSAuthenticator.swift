//
//  RMSAuthenticator.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 23/09/2024.
//

import Foundation
import SMP
class RMSAuthenticator {
  func fetchJWTToken(for serviceID: String, completion: @escaping (String?) -> Void){
    let url = URL(string: "https://rms.api.bbc.co.uk/v2/sign/token/\(serviceID)")!
    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
//      let jwt = String(data: data, encoding: .utf8)
//      completion(jwt)
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let token = jsonObject["token"] as? String {
                completion(token)
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
        }
    }.resume()
  }
}
