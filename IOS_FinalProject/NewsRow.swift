//
//  NewsRow.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/9.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI
import URLImage

struct NewsRow: View {
    @State var news:Articles
    @State private var theURL = ""
    @State private var showWebPage = false
    var body: some View {
        VStack{
            Text(NSLocalizedString("BBC Top-10 News", comment: "default"))
                .fontWeight(.bold)
                .font(.system(size:30))
                .foregroundColor(.red)
            Spacer()
            List{
                ForEach(0..<self.news.articles.count, id: \.self){ (index) in
                    Button(action:{
                        self.theURL = self.news.articles[index].url
                        self.showWebPage = true
                    }){
                    HStack{
                        URLImage(URL(string: self.news.articles[index].urlToImage!)!,placeholder: {(_) in Image(systemName:"photo")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .frame(width:120,height:80)
                            .cornerRadius(20)
                            .shadow(radius: 30)}) { (proxy) in
                                proxy.image
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:120, height: 80)
                                    .cornerRadius(5)
                                    .shadow(radius: 30)
                        }
                        Text(self.news.articles[index].title)
                            .fontWeight(.bold)
                            .font(.system(size:20))
                        }}.sheet(isPresented:self.$showWebPage){
                            SafariView(url: URL(string: self.theURL)!)
                    }
                }
                
            }.onAppear{
                ApiControl.shared.getNewsAPI(){
                    (result) in
                    switch result {
                    case .success(let AllPost):
                        self.news = AllPost
                    case .failure( _):
                        print("Error")
                    }
                }
            }
        }
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(news: Articles(articles: []))
    }
}
