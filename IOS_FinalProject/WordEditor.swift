//
//  WordEditor.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct WordEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var wordsData: WordData
    @State private var words = ""
    @State private var part_of_speech = ""
    @State private var meaning = ""
    @State private var sentence = ""
    @State private var isWord = true
    @State private var isFavor = false
    @State private var showAlert = false
    @State private var showWordList = false
    @State private var text = "單字"
    @State private var test = ""
    @State private var myPlaceholder = "意思"
    @State var myText: String
    @State var myWord: String
    @State var myPartOfSpeech: String
    var editWord: Word?
    var roles = [NSLocalizedString("n.名詞", comment: "default"),NSLocalizedString("v.動詞", comment: "default"),NSLocalizedString("adj.形容詞", comment: "default"),NSLocalizedString("adv.副詞", comment: "default"),NSLocalizedString("prep.介系詞", comment: "default"),NSLocalizedString("conj.連接詞", comment: "default")]
    var body: some View {
        Form {
            TextField(NSLocalizedString("單字", comment: "default"), text: $words)
            Toggle(isWord ? "單字/片語":"諺語",isOn:$isWord)
            if isWord{
                TextField(NSLocalizedString("詞性", comment: "default"), text: self.$part_of_speech)
            }
//                Button(action:{
//                    if self.showWordList == false{
//                        self.showWordList = true
//                    }
//                    else{
//                        self.showWordList = false
//                    }
//                    print(self.showWordList)
//                }){
//                    Text(NSLocalizedString("詞性", comment: "default")).foregroundColor(.black)+Text("   ")+Text(self.roles[part_of_speech])
//                        .foregroundColor(.black)
//                }
//                if self.showWordList == true{
//                    VStack{
//                        Picker(selection: $part_of_speech, label: Text("詞性")) {
////                            //List{
//                            ForEach(0..<roles.count,id:\.self){(index) in
////                                Button(action:{
////                                    self.test = self.roles[index]
////                                    self.part_of_speech = index
////                                    print(self.test)
////                                    self.showWordList = false
////                                })
//                                Text(self.roles[index]).tag(index)
//                                }
//                            }
////                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    .labelsHidden()
//                    .clipped()
//                }
//            }
            //MultilineTextField(NSLocalizedString("意思", comment: "default"),text:$meaning)
            MultilineTextField(NSLocalizedString(self.myPlaceholder, comment: "default"),text:$meaning)
            MultilineTextField(NSLocalizedString("句子", comment: "default"),text:$sentence)
            Toggle("最愛", isOn: $isFavor)
        }
        .navigationBarTitle("新增單字")
        .navigationBarItems(trailing: Button("儲存") {
            if(self.words == "") || (self.meaning == "" || (self.sentence=="")) {
                self.showAlert = true
            }
            else{
                print(self.words)
                let word = Word(words: self.words, isWord: self.isWord, part_of_speech: self.part_of_speech, meaning: self.meaning, sentence: self.sentence, isFavor:self.isFavor)
                
                if let editWord = self.editWord {
                    let index = self.wordsData.Words.firstIndex {
                        $0.id == editWord.id
                        }!
                    self.wordsData.Words[index] = word
                } else {
                    print("Insert")
                    self.wordsData.Words.insert(word, at: 0)
                }
                self.presentationMode.wrappedValue.dismiss()
            }
        } .alert(isPresented: $showAlert) {
            () -> Alert in
            return Alert(title: Text("儲存失敗"), message: Text("單字或意思沒輸入是要背什麼？"))})
            .onAppear {
                if self.myWord != "" {
                    self.part_of_speech = self.myPartOfSpeech
                    self.meaning = self.myText
                    self.words = self.myWord
                }
                if self.meaning != ""{
                    self.myPlaceholder = ""
                }
                if let editWord = self.editWord {
                    self.words = editWord.words
                    self.part_of_speech=editWord.part_of_speech
                    self.isWord = editWord.isWord
                    self.meaning = editWord.meaning
                    self.sentence = editWord.sentence
                    self.isFavor = editWord.isFavor
                    //self.test = self.roles[self.part_of_speech]
                }
        }
        
    }
}

struct WordEditor_Previews: PreviewProvider {
    static var previews: some View {
        WordEditor(wordsData: WordData(), myText: "", myWord: "", myPartOfSpeech: "")
    }
}

