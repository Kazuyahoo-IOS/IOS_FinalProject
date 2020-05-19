//
//  CircleProcessView.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/19.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct CircleProcessView: View {
    @State private var trimEnd: CGFloat = 0
    var process:Double
    var body: some View {
        ZStack{
            Text("完成進度 " + String(format:"%.1f",process*100) + "%")
            Circle()
                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 30,
                                                        lineCap: .round))
                .frame(width:300,height:300)
            Circle()
                .trim(from: 0, to: trimEnd)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 30,
                                                       lineCap: .round))
                .frame(width: 300, height: 300)
                .animation(.linear(duration: 1))
                .onAppear {
                    self.trimEnd = CGFloat(self.process)
            }
        }.offset(y:50)
    }
}

struct CircleProcessView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProcessView(process:0.5)
    }
}
