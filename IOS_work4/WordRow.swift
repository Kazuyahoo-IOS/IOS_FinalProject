//
//  WordRow.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct WordRow: View {
    var word: Word
    var roles = ["n.名詞","v.動詞","adj.形容詞","adv.副詞","prep.介系詞","conj.連接詞"]
    var body: some View {
        HStack {
            Text(word.words)
            if(word.isWord){
                Text(roles[word.part_of_speech])
                    .padding(.leading)
            }
            else{
                Text("片語")
                    .padding(.leading)
            }
            Spacer()
            Image(systemName: word.isFavor ? "star.fill" : "star")
        }.padding(.horizontal)
    }
}

struct WordRow_Previews: PreviewProvider {
    static var previews: some View {
        WordRow(word:Word(words:"refrigerator",isWord:true,part_of_speech:0,meaning:"sth that can store food", sentence: "My mon bought a refrigerator yesterday.",isFavor:true))
    }
}
