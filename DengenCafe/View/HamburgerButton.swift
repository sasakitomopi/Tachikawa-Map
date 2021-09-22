//
//  HamburgerButton.swift
//  DengenCafe
//
//  Created by user on 2021/09/20.
//

import SwiftUI

struct HamburgerButton: View {
    @State private var currentOffset = CGFloat()
    @State private var closeOffset = CGFloat()
    @State private var openOffset = CGFloat()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

final class HamburgerButtonFloat{
    func configure(
        currentOffset:CGFloat,
        closeOffset:CGFloat,
        openOffset:CGFloat,
        viewWidth:CGFloat
    ){
        //ハンバーガーメニューのViewのサイズを
        let currentOffset = (viewWidth/2) * -1+((viewWidth*0.5/2) * -1)
        let closeOffset = currentOffset
        let openOffset = ((viewWidth / 2) * -1)+((viewWidth * 0.5) / 2)
        
        
    }
}


struct HamburgerButton_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerButton()
    }
}
