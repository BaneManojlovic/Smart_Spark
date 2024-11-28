//
//  WebView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 28.11.24..
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let url = URL(string: "https://www.freeprivacypolicy.com/live/e0522db0-9239-4b5c-9dbf-529252f6624d")
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}
