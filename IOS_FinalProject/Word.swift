//
//  Word.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/17.
//  Copyright © 2020 王瑋. All rights reserved.
//

import Foundation

struct Word: Identifiable, Codable {
    var id = UUID()
    var words: String
    var isWord: Bool
    var part_of_speech: String
    var meaning: String
    var sentence: String
    var isFavor: Bool
}
