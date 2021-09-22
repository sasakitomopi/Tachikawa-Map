//
//  ContentView.swift
//  DengenCafe
//
//  Created by user on 2021/08/29.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            DengenCafeList()
                .tabItem{
                    VStack{
                        Text("List")
                        Image(systemName: "list.bullet")
                    }
                }.tag(1)
            GoogleMap()
                .tabItem {
                    VStack{
                        Text("Map")
                        Image(systemName: "mappin.circle")
                    }
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //プレビューデバイスを設定するコード
            .previewDevice(PreviewDevice(rawValue:"iPhone 12 Pro Max"))
        
    }
}

