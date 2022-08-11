//
//  ContentView.swift
//  TNS-SWIFT-UI
//
//  Created by Tales Valente on 10/08/22.
//

import SwiftUI

struct  URLImage: View {
    let urlString: String
    @State var data: Data?

    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        }
        else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()

                }
        }
    }
        private func fetchData() {
          let baseUrl = "http://adaspace.local/"
            guard let url = URL(string: baseUrl + urlString) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                self.data = data
        }
            task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModelPosts()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts, id: \.self) { post in
                    HStack {
                  
                            URLImage(urlString: post.media ?? "media/4a421607200ad691416b5c0981f4d2.png")
                                .frame(width: 130, height: 70)
                                .background(Color.gray)
                        
         
                            Text(post.content)
                            .bold()
                        
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Listagens Posts")
            .onAppear {
                viewModel.fetch()
            }
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
