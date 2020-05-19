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
    @State private var part_of_speech = 0
    @State private var meaning = ""
    @State private var sentence = ""
    @State private var isWord = true
    @State private var isFavor = false
    @State private var showAlert = false
    var editWord: Word?
    var roles = ["n.名詞","v.動詞","adj.形容詞","adv.副詞","prep.介系詞","conj.連接詞"]
    var body: some View {
        Form {
            TextField("Word", text: $words)
            Toggle("單字？",isOn:$isWord)
            if isWord{
                Picker(selection: $part_of_speech, label: Text("詞性")) {
                    ForEach(0..<roles.count,id:\.self){(index) in
                        Text(self.roles[index]).tag(index)
                        }
                    }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 42)
                .clipped()
            }
            MultilineTextField("meaning",text:$meaning)
            MultilineTextField("sentence",text:$sentence)
            Toggle("最愛", isOn: $isFavor)
        }
        .navigationBarTitle("Add new Word")
        .navigationBarItems(trailing: Button("Save") {
            if(self.words == "") || (self.meaning == "" || (self.sentence=="")) {
                self.showAlert = true
            }
            else{
                let word = Word(words: self.words, isWord: self.isWord, part_of_speech: self.part_of_speech, meaning: self.meaning, sentence: self.sentence, isFavor:self.isFavor)
                
                if let editWord = self.editWord {
                    let index = self.wordsData.Words.firstIndex {
                        $0.id == editWord.id
                        }!
                    self.wordsData.Words[index] = word
                } else {
                    self.wordsData.Words.insert(word, at: 0)
                }
                self.presentationMode.wrappedValue.dismiss()
            }
        } .alert(isPresented: $showAlert) {
                   () -> Alert in
            return Alert(title: Text("儲存失敗"), message: Text("單字或意思沒輸入是要背什麼？"))})
            .onAppear {
                if let editWord = self.editWord {
                    self.words = editWord.words
                    self.part_of_speech=editWord.part_of_speech
                    self.isWord = editWord.isWord
                    self.meaning = editWord.meaning
                    self.sentence = editWord.sentence
                    self.isFavor = editWord.isFavor
                }
        }

    }
}

struct WordEditor_Previews: PreviewProvider {
    static var previews: some View {
        WordEditor(wordsData: WordData())
    }
}

