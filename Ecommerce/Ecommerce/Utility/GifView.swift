//
//  GifView.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import Foundation
import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            webView.load(data!, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: URL(fileURLWithPath: path))
        }
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
