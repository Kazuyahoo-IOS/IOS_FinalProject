//
//  WebView.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/19.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
         if let url = URL(string: "https://milletbard.com/26Memory/#/") {
             let request = URLRequest(url: url)
             webView.load(request)
         }
        
         return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    typealias UIViewType = WKWebView
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
