//
//  SettingView.swift
//  IOS_FinalProject
//
//  Created by 王瑋 on 2020/6/10.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI
import URLImage
import CoreImage.CIFilterBuiltins

let userDefaults = UserDefaults.standard

struct SettingView: View {
    @State private var selectImage: UIImage?
    @State private var showImageSelect = false
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var locationPhoto = false
    @State private var scale: CGFloat = 1
    @State private var show = false
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack{
            Spacer()
            if userDefaults.string(forKey: "thePhotoPath") != nil && self.locationPhoto == false {
                URLImage(URL(string: userDefaults.string(forKey: "thePhotoPath")!)!){ proxy in
                    proxy.image
                        .resizable()
                        .scaledToFill()
                        .frame(width:200, height: 200)
                        .cornerRadius(.infinity)
                        .shadow(radius: 30)
                        .scaleEffect(self.scale)
                        .transition(.slide)
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                self.scale = value.magnitude
                        } .onEnded { value in
                            self.scale = 1
                        })
                }
            }
            else if self.locationPhoto == true && self.selectImage != nil{
                Image(uiImage: self.selectImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width:200, height: 200)
                    .cornerRadius(.infinity)
                    .shadow(radius: 30)
                    .contextMenu {
                        Button(action: {
                            // self.show=false
                        }) {
                            HStack {
                                Text("Disappear!")
                                Image(systemName: "trash.fill")
                            }
                        }
                        Button(action: {
                        }) {
                            HStack {
                                Text("Nothing happened")
                                Image(systemName: "trash.slash")
                            }
                        }
                }
            }
            HStack{
                Spacer()
                Button(action:{
                    self.locationPhoto = true
                    self.showAlert2 = true
                }){
                    Text("更換照片")
                }
                    .sheet(isPresented: self.$showImageSelect){
                        ImagePickerController(selectImage: self.$selectImage, showSelectPhoto: self.$showImageSelect)
                }
                    .alert(isPresented: $showAlert2){
                        Alert(title: Text("貼心提醒"), message: Text("更換圖片後記得按儲存鈕存檔"),dismissButton: .default(Text("知道了"), action: {
                            self.showImageSelect = true
                        }))}
                Spacer()
                Button(action:{
                    if self.selectImage != nil {
                        ApiControl.shared.uploadImage(uiImage: self.selectImage!){
                            (result) in
                            switch result{
                            case .success(let link):
                                userDefaults.set(link, forKey:"thePhotoPath")
                                print("userDf: " + userDefaults.string(forKey: "thePhotoPath")!)
                            case .failure( _):
                                print("upLoad Image Error.")
                            }
                        }
                    }else{
                        self.showAlert = true
                    }
                }){
                    Text("儲存")
                }//.padding(.trailing,20)
                Spacer()
            }
            Form{
                HStack(){
                    Text("版本資訊")
                    Spacer()
                    Text("1.25")
                        .foregroundColor(.gray)
                }
                
                HStack(){
                    Text("關於此應用程式")
                    Spacer()
                    Text("敬請期待")
                        .foregroundColor(.gray)
                }
                
                HStack(){
                    Text("特別感謝")
                    Spacer()
                    Text("李hopeful同學、PeterPan")
                        .foregroundColor(.gray)
                }
                VStack{
                    Spacer(minLength: 50)
                    Text("歡迎參觀我的其他作品:)")
                    VStack{
                        if self.show{
                            Image(uiImage: generateQRCode(from: "https://github.com/kazuyahooo"))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .transition(.slide)
                        }}
                        .animation(.easeInOut(duration:1.2))
                        .onAppear {
                            self.show = true
                            
                    }
                    .onDisappear {
                        self.show = false
                        
                    }
                }.offset(x:25)
            }
            Spacer()
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
