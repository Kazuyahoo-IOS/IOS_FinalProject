//
//  WordList.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct WordList: View {
    @ObservedObject var wordsData : WordData
//    var body: some View{
//        CustomScrollView(wordsData:wordsData)
//    }
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
                    NavigationLink(destination: WordEditor(wordsData: self.wordsData,  myText: "", myWord: "", myPartOfSpeech: "",editWord: word)) {
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
            .navigationBarItems(leading: EditButton().font(.system(size:25)) , trailing: Button(action: {
                self.showEditWord = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size:25))
            })
                .sheet(isPresented: $showEditWord) {
                    NavigationView {
                        WordEditor(wordsData: self.wordsData, myText: "", myWord: "", myPartOfSpeech: "")
                    }
            }
        }
    }
}

struct WordSubList : View{
    var wordsData:WordData
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
                    NavigationLink(destination: WordEditor(wordsData: self.wordsData,  myText: "", myWord: "", myPartOfSpeech: "",editWord: word)) {
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
            .navigationBarItems(leading: EditButton().font(.system(size:25)) , trailing: Button(action: {
                self.showEditWord = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size:25))
            })
                .sheet(isPresented: $showEditWord) {
                    NavigationView {
                        WordEditor(wordsData: self.wordsData, myText: "", myWord: "", myPartOfSpeech: "")
                    }
            }
        }
    }
}

struct CustomScrollView : UIViewRepresentable {
    var wordsData: WordData
    //@State var userGetProfile:UGProfileDec
    //@State var AllUserPostList:[MyData]
    //var width : CGFloat
//    var height : CGFloat
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        //control.refreshControl?.addTarget(context.coordinator, action:
            //#selector(Coordinator.handleRefreshControl), for: .valueChanged)
        let childView = UIHostingController(rootView: WordSubList(wordsData:wordsData))
        //childView.view.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
        
        control.addSubview(childView.view)
        return control
    }
    func updateUIView(_ uiView: UIScrollView, context: Context)  {
        //print("Update View")
    }
    class Coordinator: NSObject {
        var control: CustomScrollView
        init(_ control: CustomScrollView) {
            self.control = control
        }
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
        }
//            ApiControl.shared.GetProfileAPI(UserID: self.control.userGetProfile.id){
//                (result) in
//                switch result{
//                case .success(let userProfile):
//                    self.control.userGetProfile = userProfile
//                case .failure( _):
//                    print("Update Error.")
//                }
//            }
//            ApiControl.shared.GetAllPostAPI{
//                (result) in
//                switch result {
//                case .success(let AllPost):
//                    var count = 0
//                    for i in 0...AllPost.count - 1{
//                        if AllPost[i].userID == self.control.userGetProfile.id {
//                            count += 1
//                        }
//                    }
//                    if self.control.AllUserPostList.count != count{
//                        self.control.AllUserPostList.removeAll()
//                        for i in 0...AllPost.count - 1{
//                            if AllPost[i].userID == self.control.userGetProfile.id {
//                                self.control.AllUserPostList.append(AllPost[i])
//                            }
//                        }
//                    }
//                case .failure( _):
//                    print("Error")
//                }
//            }
            
//            print("Refreshing")
//        }
    }
}
//struct WordList_Previews: PreviewProvider {
//    static var previews: some View {
//        WordList(wordsData: WordData)
//    }
//}
