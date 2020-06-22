//
//  ApiControl.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/9.
//  Copyright © 2020 王瑋. All rights reserved.
//

import Foundation
import UIKit
import Combine
import Alamofire

class ApiControl{
    static let shared = ApiControl()
    
    func GetTime() -> String{
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let StringYear = String(year)
        var StringMon = String(month)
        var StringDay = String(day)
       
        if month < 10{
            StringMon = "0" + String(month)
        }
        if day < 10{
            StringDay = "0" + String(day)
        }
        
        return StringYear + "-" + StringMon + "-" + StringDay
    }
    
    func getNewsAPI(completion: @escaping((Result<Articles, NetworkError>) -> Void)){
        let urlStr = "http://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=20eb00d899764cce8d491747c9229252"
        //let urlStr = "http://newsapi.org/v2/everything?q=Apple&from=2020-06-07&sortBy=popularity&apiKey=20eb00d899764cce8d491747c9229252"
        if let url = URL(string: urlStr) {
           URLSession.shared.dataTask(with: url) { (data, response , error) in
              let decoder = JSONDecoder()
            if let data = data, let posts = try? decoder.decode(Articles.self, from: data) {
                completion(.success(posts))
                print(posts.articles)
              }else{
                //print(String(data: data!, encoding: .utf8))
                completion(.failure(NetworkError.Error))
            }
           }.resume()
        }
    }
    
    func getDefinitionAPI(word: String, completion: @escaping((Result<[Wordnik], NetworkError>) -> Void)){
        let urlStr = "https://api.wordnik.com/v4/word.json/" + word + "/definitions?limit=200&includeRelated=false&sourceDictionaries=all&useCanonical=false&includeTags=false&api_key=pnzv1esee3zqrfpeuhd3i7dlkz1r5hkdi3rgf7frybdl5hu7w"
        
        if let url = URL(string: urlStr) {
           URLSession.shared.dataTask(with: url) { (data, response , error) in
              let decoder = JSONDecoder()
            if let data = data, let posts = try? decoder.decode([Wordnik].self, from: data) {
                completion(.success(posts))
                print(posts)
              }else{
                //print(String(data: data!, encoding: .utf8))
                completion(.failure(NetworkError.Error))
            }
           }.resume()
        }
    }
    
    func uploadImage(uiImage: UIImage, completion:@escaping((Result<String, NetworkError>) -> Void)){
        //var cancellable: AnyCancellable
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 205ca25da75b199",
        ]
        AF.upload(multipartFormData: { (data) in
            let imageData = uiImage.jpegData(compressionQuality: 0.8)
            data.append(imageData!, withName: "image")
        }, to: "https://api.imgur.com/3/upload", headers: headers).responseDecodable(of: UploadImageResult.self, queue: .main, decoder: JSONDecoder()){(response) in
            switch response.result {
            case .success(let result):
                completion(.success(result.data.link))
                print(result.data.link)
            case .failure(let error):
                completion(.failure(NetworkError.Error))
                print(error)
            }
        }
    }
    
}
