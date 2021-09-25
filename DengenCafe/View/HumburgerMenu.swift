//
//  HumburgerMenu.swift
//  DengenCafe
//
//  Created by user on 2021/09/23.
//

import SwiftUI

struct HumburgerMenu: View {
    var body: some View {
        GeometryReader { geometory in
            VStack(alignment: .leading ){
                Text("Menu")
                    .font(.title)
                Divider()
                ScrollView(.vertical,showsIndicators: true){
                    Text("現在地を確認する")
                        .font(.subheadline)
                    Text("口コミを投稿する")
                        .font(.subheadline)
                }
                
            }
        }
    }
}
struct HumburgerMenu_Previews: PreviewProvider {
    static var previews: some View {
        HumburgerMenu()
    }
}
