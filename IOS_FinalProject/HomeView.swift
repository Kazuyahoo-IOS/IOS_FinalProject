//
//  HomeView.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/10.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    // 1.
    @FetchRequest(
        // 2.
        entity: Dict.entity(),
        // 3.
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Dict.historyWord, ascending: true)
        ]
        //,predicate: NSPredicate(format: "genre contains 'Action'")
        // 4.
    ) var dicts: FetchedResults<Dict>
    
    @State var wordnik : Wordnik
    @ObservedObject var wordsData : WordData
    @State private var searchText = ""
    @State private var word = ""
    @State private var showEditWord = false
    @State private var showSetting = false
    @State private var showMore = false
    @State private var maxCount = 0
    
    var body: some View {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30)!]
        return NavigationView {
            VStack{
                Spacer()
                HStack{
                    SearchBar(text: $searchText)
                    Button(action:{
                        self.word = self.searchText
                        if self.word != ""{
                            ApiControl.shared.getDefinitionAPI(word:self.word){
                                (result) in
                                switch result {
                                case .success(let AllPost):
                                    for i in 0 ..< AllPost.count{
                                        self.wordnik = AllPost[i]
                                        let hasMark = self.wordnik.text?.contains("<")
                                        if self.wordnik.text != "" && hasMark == false{
                                            break
                                        }
                                    }
                                    
                                case .failure( _):
                                    print("Error")
                                }
                                self.showEditWord = true;
                                self.addDict(historyWord: self.word, historyMeaning: self.wordnik.text ?? "", historyPartOfSpeech: self.wordnik.partOfSpeech!)
                                if self.dicts.count >= 6 {self.maxCount = 6}
                                else {self.maxCount = self.dicts.count}
                            }}}){
                                Text("goto")
                    }
                }
                .padding()
                //.offset(y:-50)
                Spacer()
                List {
                    ForEach (0 ..< self.maxCount, id: \.self){ (index) in
                        //ForEach(dicts, id: \.historyWord) {
                        HistoryRow(dict: self.dicts[index])
                    }
                    .onDelete(perform: deleteDict)
                }
                Button(action:{self.maxCount = self.dicts.count}){
                        
//                        NavigationLink(destination: DictionaryView(term:searchText)){
                            Text("載入更多")
//                        }
                }
                Spacer()
                
            }
            .onAppear{
                UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30)!]
//                print (self.dicts.count)
                if self.dicts.count >= 6 {self.maxCount = 6}
                else {self.maxCount = self.dicts.count}
//                print(self.maxCount)
//                if self.showMore == true {
//
//                }
            }
            .navigationBarTitle(Text("字典").font(.subheadline),displayMode: .inline)
            .navigationBarItems(trailing: Button(action:{
                self.showSetting = true
            }) {
                NavigationLink(destination:SettingView()){
                    Image(systemName:"gear")
                        .font(.system(size:25))}
                }
            )
                .sheet(isPresented: $showEditWord) {
                    NavigationView {
                        WordEditor(wordsData: self.wordsData, myText: self.wordnik.text ?? "", myWord: self.searchText, myPartOfSpeech: self.wordnik.partOfSpeech!)
                    }
            }
        }
    }
    
    func deleteDict(at offsets: IndexSet) {
        // 1.
        //self.maxCount -= 1
        if self.dicts.count - 1 >= 6 {self.maxCount = 6}
        else {self.maxCount = self.dicts.count - 1}
        offsets.forEach { index in
            // 2.
            let dict = self.dicts[index]
            
            // 3.
            self.managedObjectContext.delete(dict)
            
        }
        
        // 4.
        saveContext()
    }
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    func addDict(historyWord: String, historyMeaning: String, historyPartOfSpeech: String) {
        // 1
        let newDict = Dict(context: managedObjectContext)
        
        // 2
        newDict.historyWord = historyWord
        newDict.historyMeaning = historyMeaning
        newDict.historyPartOfSpeech = historyPartOfSpeech
        
        // 3
        saveContext()
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(wordnik: Wordnik(partOfSpeech: "", text: "", word: ""))
//    }
//}
