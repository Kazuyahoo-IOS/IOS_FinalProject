//
//  AppView.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var wordsData = WordData()
    var body: some View {
        ZStack{
            TabView {
                WordList()
                    .tabItem{
                        Image(systemName:"list.bullet")
                        Text("單字表")
                }
                WebView()
                    .tabItem{
                        Image(systemName:"person.3.fill")
                        Text("學習計畫")
                }
                ChartView(wordsData: self.wordsData)
                    .tabItem{
                        Image(systemName:"magnifyingglass.circle.fill")
                        Text("分析")
                            .lineLimit(nil)
                }
            }
            .accentColor(.purple)
        }
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
