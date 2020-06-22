//
//  SafariView.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/10.
//  Copyright © 2020 王瑋. All rights reserved.
//

import Foundation
import SwiftUI
import SafariServices
struct SafariView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
    
    
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://www.google.com/")!)
    }
}
