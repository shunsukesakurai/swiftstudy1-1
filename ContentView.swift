//
//  ContentView.swift
//  MyMap
//
//  Created by saku on 2021/07/06.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var inputText:String="" // 入力中の検索文字列を保存する
    @State var dispSearchKey:String="" // 検索キーワードを保存する状態変数
    @State var dispMapType:MKMapType = .standard

    var body: some View {
    
        VStack{
            //TextFieldを作成、第一引数：フィールドに表示する内容、第二引数：入力されたデータを保持する変数、第三引数：入力確定時の処理
            // inputTextに$が付いてるのは、状態変数を指定するため
            TextField("キーワードを入力してください",text:$inputText,onCommit:{
                dispSearchKey=inputText
                print("input keyword:"+dispSearchKey)
            })
            .padding()
            ZStack(alignment:.bottomTrailing){
                MapView(searchKey: dispSearchKey,mapType:dispMapType)
                
                // マップ切り替えボタン
                Button(action:{
                    if dispMapType == .standard{
                        dispMapType = .satellite
                    }else if dispMapType == .satellite{
                        dispMapType = .hybrid
                    }else if dispMapType == .hybrid{
                        dispMapType = .satelliteFlyover
                    }else if dispMapType == .satelliteFlyover{
                        dispMapType = .hybridFlyover
                    }else if dispMapType == .hybridFlyover{
                        dispMapType = .mutedStandard
                    }else{
                        dispMapType = .standard
                    }
                }){
                    Image(systemName:"map")
                        .resizable()
                        .frame(width:35.0,
                               height: 35.0,
                               alignment: .leading)
                }
                .padding(.trailing,20.0)
                .padding(.bottom,30.0)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
