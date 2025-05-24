//
//  CustomImageView.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI

struct CustomImageView: View {
    @ObservedObject var viewModel:CustomImageViewModel
    var body: some View {
        if let urlStr = viewModel.url , let url = URL(string: urlStr) {
            CachedAsyncImage(url: url,urlCache: URLCache.imageCache) {
                 phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(width: viewModel.size.width,height: viewModel.size.height)
                case .failure(let error):
                    Image(systemName: "xmark.octagon")
                @unknown default:
                    Image(systemName: "xmark.octagon")
                }
            }
        }
        else if let title = viewModel.title {
            ZStack {
                Text(title.prefix(1).uppercased()).foregroundStyle(Color.white)
            }.background(Color.blue)
        }
        else {
            Image(systemName: "photo")

        }
    }
}
class CustomImageViewModel:ObservableObject {
    var url:String?
    var title:String?
    var size:CGSize = CGSize(width: 50, height: 50)
    init(url: String? = nil, title: String? = nil, size: CGSize) {
        self.url = url
        self.title = title
        self.size = size
    }
}

