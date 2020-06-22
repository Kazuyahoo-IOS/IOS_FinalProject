//
//  struct.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/9.
//  Copyright © 2020 王瑋. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case Error
}

struct News:Codable{
    var title:String
    var url : String
    var urlToImage:String?
}

struct Articles:Codable{
    var articles: [News]
}

struct Wordnik:Codable{
    var partOfSpeech : String?
    var text : String?
    var word : String
}

struct UploadImageResult: Decodable {
    struct UIRData: Decodable {
        let link: String
    }
    let data: UIRData
}

