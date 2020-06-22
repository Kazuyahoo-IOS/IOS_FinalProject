//
//  HistoryRow.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/18.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct HistoryRow: View {
    let dict: Dict
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                //Spacer()
                dict.historyWord.map(Text.init)
                .foregroundColor(.purple)
                .font(.title)
                Spacer()
                dict.historyPartOfSpeech.map(Text.init)
                //  .font(.caption)
                Spacer()
            }
            dict.historyMeaning.map(Text.init)
            //.font(.caption)
            
        }
    }
}
