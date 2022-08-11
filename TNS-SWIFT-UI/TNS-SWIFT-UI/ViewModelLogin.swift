//
//  ViewModel.swift
//  TNS-SWIFT-UI
//
//  Created by Tales Valente on 10/08/22.
//
//BRANCH VALENTE

import Foundation
import SwiftUI

struct Users: Hashable, Codable {
    let name: String
    let senha: String
}

class ViewModelLogin: ObservableObject {
    @Published var users: [Users] = []
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //Convert to JSON
            do {
                let users = try JSONDecoder().decode([Users].self, from: data)
                DispatchQueue.main.async {
                    self?.users = users
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
