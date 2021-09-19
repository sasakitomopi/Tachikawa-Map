//
//  DengenCafeList.swift
//  DengenCafe
//
//  Created by user on 2021/09/02.
//

import SwiftUI

struct DengenCafeList: View {
    var body: some View {
        
        NavigationView{
            List(landmarks,id:\.id){landmark in
                NavigationLink(destination:LandmarkDetail(landmark: landmark)){
            //変数landmark(landmark←こっち側:landmark)に
            //jsonファイルを読み込んだlandmarkを入れて{landmark in←これ
            //DendenCafeRowに送っている
                DendenCafeRow(landmark: landmark)
            }
            }
            .navigationBarTitle("Tachikawa Cafe")
            
        }
            
    }
}

struct DengenCafeList_Previews: PreviewProvider {
    static var previews: some View {
        DengenCafeList()
            .previewDevice("iPhone 12 Pro Max")
    }
}
