//
//  ContentView.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var trimEnd: CGFloat = 0
    var body: some View {
        Circle()
            .trim(from: 0, to: trimEnd)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 30,
                                                   lineCap: .round))
            .frame(width: 300, height: 300)
            .animation(.linear(duration: 2))
            .onAppear {
                self.trimEnd = 0.75
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
