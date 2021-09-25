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
        HamburgerButtonView(currentOffset:$currentOffset,closeOffset:$closeOffset,openOffset:$openOffset)
    }
}

struct HamburgerButtonView : View{
    
    @Binding var currentOffset : CGFloat
    @Binding var closeOffset : CGFloat
    @Binding var openOffset : CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 107/255, green: 142/255, blue: 35/255).edgesIgnoringSafeArea(.all)
                VStack {
                    Button(action:{
                        self.toggleHamburgerMenu()
                    }){
                        Image(systemName: "line.3.horizontal.circle.fill")
                    }
                }
            }
        }
    }
    
    func setInitPosition(viewWidth:CGFloat) {
        self.currentOffset = (viewWidth/2) * -1 + ((viewWidth * 0.5) / 2) * -1
        self.closeOffset = self.currentOffset
        self.openOffset = ((viewWidth / 2) * -1) + ((viewWidth * 0.5) / 2)
    }
    
    func toggleHamburgerMenu(){
        if(self.currentOffset == self.openOffset){
            self.currentOffset = self.closeOffset
        }else{
            self.currentOffset = self.openOffset
        }
    }
}




struct HamburgerButton_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerButton()
    }
}
