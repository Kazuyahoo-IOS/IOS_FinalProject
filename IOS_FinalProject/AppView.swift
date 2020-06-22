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
                HomeView(wordnik: Wordnik(partOfSpeech: "", text: "", word: ""),wordsData: wordsData)
                    .tabItem{
                        Image(systemName:"house.fill")
                        Text("首頁")
                }
                WordList(wordsData: wordsData)
                    .tabItem{
                        Image(systemName:"list.bullet")
                        Text("單字表")
                }
                NewsRow(news:Articles(articles: []))
                    .tabItem{
                        Image(systemName:"tv.fill")
                        Text("新聞")
                            .lineLimit(nil)
                }
                WebView()
                    .tabItem{
                        Image(systemName:"person.3.fill")
                        Text("學習計畫")
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
