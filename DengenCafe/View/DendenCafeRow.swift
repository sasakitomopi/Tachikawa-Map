//
//  DendenCafeRow.swift
//  DengenCafe
//
//  Created by user on 2021/08/31.
//

import SwiftUI

struct DendenCafeRow: View {
    //Landmarkクラスを参照したlandmark変数を定義する
    //View側で定義しただけだとその変数になにが入るかがわからないのでエラーになる
    var landmark : Landmark
    
    var body: some View {
        HStack{
            landmark.image
                .resizable()
                .frame(width:50,height: 50)
            VStack(alignment:.leading){
                Text(landmark.name)
                Text(landmark.category)
            }
            Spacer()
        }
    }
}

struct DendenCafeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        //そのため、Preview側でModelData(JSONファイル読み込み用)のlandmarksを変数の中に入れている
        DendenCafeRow(landmark:landmarks[0])
        DendenCafeRow(landmark:landmarks[1])
        }
        .previewLayout(.fixed(width:300,height:150))
    }
}
