//
//  CircleImage.swift
//  DengenCafe
//
//  Created by user on 2021/08/29.
//

import SwiftUI

struct CircleImage: View {
    var image : Image
    var body: some View {
        image
            .resizable()
            .frame(width:300,height:300)
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.gray,lineWidth: 4)
                .shadow(radius: 10))
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image:Image("Starbucks"))
            .previewDevice("iPhone 12 Pro Max")
    }
}
