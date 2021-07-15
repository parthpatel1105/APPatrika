//
//  ImageLoader.swift
//  APPatrika
//
//  Created by Parth Patel on 15/07/21.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image = Image("placeholder")
    
    func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { [weak self] uiImage in
            guard let self = self else { return }
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct RemoteImage: View {
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("").resizable()
    }
}

struct ArticleRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        imageLoader.image.resizable()
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
        
    }
    
}

