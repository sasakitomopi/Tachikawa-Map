//
//  ContentView.swift
//  DengenCafe
//
//  Created by user on 2021/08/29.
//

import SwiftUI

struct LandmarkDetail: View {
    var landmark:Landmark
    
    var body: some View {
        
        VStack {
            
            MapView(coordinate: landmark.locationCoordinates)
                .edgesIgnoringSafeArea(.all)
                .frame(height:300)
            
            
            CircleImage(image:landmark.image)
                .offset(y:-130)
                .padding(.bottom,-130)
            
            
            Text(landmark.name)
                .font(.title)
            Text(landmark.subName)
                .font(.title3)
            Text(landmark.category)
                .font(.subheadline)
            VStack(alignment:.leading){
                
                
                
                Spacer()
                
            }
            Spacer()
        }
        
        
    }
    
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            LandmarkDetail(landmark: landmarks[0])
                //プレビューデバイスを設定するコード
                .previewDevice(PreviewDevice(rawValue:"iPhone 12 Pro Max"))
        }
        
        
    }
}
