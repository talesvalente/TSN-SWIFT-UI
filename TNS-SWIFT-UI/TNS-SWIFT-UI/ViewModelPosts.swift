//
//  ViewModel.swift
//  TNS-SWIFT-UI
//
//  Created by Tales Valente on 10/08/22.
//
//BRANCH VALENTE

import Foundation
import SwiftUI

struct Posts: Hashable, Codable {
    let id: String
    let content: String
    let media: String?
//    let like_count: Int
    let user_id: String
    let created_at: String
    let updated_at: String
}

class ViewModelPosts: ObservableObject {
    @Published var posts: [Posts] = []
    func fetch() {
        guard let url = URL(string: "http://adaspace.local/posts") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //Convert to JSON
            do {
                let posts = try JSONDecoder().decode([Posts].self, from: data)
                DispatchQueue.main.async {
                    self?.posts = posts
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
