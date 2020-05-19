//
//  ChartView.swift
//  IOS_work4
//
//  Created by 王瑋 on 2020/5/19.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject var wordsData = WordData()
    var index:Double = 0
    var percentAmount:[Double] = [0, 0, 0, 0, 0,0]
    var countType:[Double] = [0, 0, 0, 0, 0, 0]
    var anglesAmount = [Angle]()
    var startDegree: Double = 0
    var process:Double=0
    var chart = ["詞性分類", "完成進度"]
    @State private var selectChart: String = "詞性分類"
    let roles = ["n.名詞","v.動詞","adj.形容詞","adv.副詞","prep.介系詞","conj.連接詞"]
    init(wordsData: WordData) {
        for word in wordsData.Words {
            index += 1;
            if word.part_of_speech == 0 {
                countType[0] += 1;
            } else if word.part_of_speech == 1 {
                countType[1] += 1;
            } else if word.part_of_speech == 2 {
                countType[2] += 1;
            } else if word.part_of_speech == 3 {
                countType[3] += 1;
            } else if word.part_of_speech == 4 {
                countType[4] += 1;
            }
            else {
                countType[5] += 1;
            }
            if(word.isFavor==true){
                process += 1;
            }
        }
        
        percentAmount[0] = countType[0] / index
        percentAmount[1] = countType[1] / index
        percentAmount[2] = countType[2] / index
        percentAmount[3] = countType[3] / index
        percentAmount[4] = countType[4] / index
        percentAmount[5] = countType[5] / index
        process /= index
        for percent in percentAmount {
            anglesAmount.append(.degrees(startDegree))
            startDegree += 360 * percent
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: self.$selectChart, label: Text("請選擇統計項目：")) {
                    ForEach(self.chart, id: \.self) {
                        (text) in Text(text)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding(20)
                if self.selectChart == "詞性分類" {
                    VStack {
                        Spacer()
                        PieChartView(startAngle: anglesAmount)
                            .frame(width: 300, height: 300)
                        Spacer()
                        HStack(alignment: .top){
                            Group{
                                Color.blue.frame(width: 10, height: 10)
                                    .offset(y:7)
                                Text("n. " + String(format: "%.1f", percentAmount[0] * 100) + "%")
                                Color.green.frame(width: 10, height: 10)
                                .offset(y:7)
                                Text("v. " + String(format: "%.1f", percentAmount[1] * 100) + "%")
                                Color.yellow.frame(width: 10, height: 10)
                                .offset(y:7)
                                Text("adj. " + String(format: "%.1f", percentAmount[2] * 100) + "%")}}
                        HStack(alignment: .top){
                            Color.red.frame(width: 10, height: 10)
                            .offset(y:7)
                            Text("adv. " + String(format: "%.1f", percentAmount[3] * 100) + "%")
                            Color.orange.frame(width: 10, height: 10)
                            .offset(y:7)
                            Text("prep. " + String(format: "%.1f", percentAmount[4] * 100) + "%")
                            Color.purple.frame(width: 10, height: 10)
                            .offset(y:7)
                            Text("conj. " + String(format: "%.1f", percentAmount[5] * 100) + "%")
                        }
                    }
                    .padding()
                } else if self.selectChart == "完成進度" {
                    CircleProcessView(process:process)
                        .offset(y:80)
                }
                Spacer()
            }
            .navigationBarTitle("學習分析")
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(wordsData: WordData())
    }
}
