//
//  DictionaryView.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/16.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct DictionaryView: UIViewControllerRepresentable{
    let term : String
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        UIReferenceLibraryViewController(term: term)
    }
    
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
        
    }
    typealias UIViewControllerType = UIReferenceLibraryViewController
}


struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView(term:"apple")
    }
}
