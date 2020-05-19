//
//  WordList.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct WordList: View {
    @ObservedObject var wordsData = WordData()
    @State private var showEditWord = false
    @State private var searchText = ""
    var filterWords: [Word] {
           return wordsData.Words.filter({ searchText.isEmpty ? true : $0.words.contains(searchText) })
       }
    var body: some View {
        NavigationView {
                List{
                    SearchBar(text: $searchText)
                    ForEach(filterWords) { (word) in
                        NavigationLink(destination: WordEditor(wordsData: self.wordsData, editWord: word)) {
                            WordRow(word:word)
                        }
                    }
                    .onDelete { (indexSet) in
                        self.wordsData.Words.remove(atOffsets: indexSet)
                    }
                    .onMove { (indexSet, index) in
                        self.wordsData.Words.move(fromOffsets: indexSet,
                                                  toOffset: index)
                    }
                }
                    
                .navigationBarTitle("單字表")
                .navigationBarItems(leading: EditButton() , trailing: Button(action: {
                    self.showEditWord = true
                }) {
                    Image(systemName: "plus.circle.fill")
                })
                    .sheet(isPresented: $showEditWord) {
                        NavigationView {
                            WordEditor(wordsData: self.wordsData)
                        }
                }
            }
    }
}

struct WordList_Previews: PreviewProvider {
    static var previews: some View {
        WordList()
    }
}
