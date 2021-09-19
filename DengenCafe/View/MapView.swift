//
//  MapView.swift
//  DengenCafe
//
//  Created by user on 2021/08/29.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @State var coordinate : CLLocationCoordinate2D

    //MapViewがどんなViewかを判断するためのメソッド
    //ここでは、MapViewを使いたいので、戻り値の型と処理の中にMKMapVIewを記載
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame:.zero)
    }
    
    //MapViewの具体的な処理を記載する部分
    func updateUIView(_ view: MKMapView, context: Context) {
        
        
        //span→地理的な範囲の広さを記載する部分
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        
        //ピン留めをする変数を記載
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        
        let region = MKCoordinateRegion(center: coordinate,span:span)
        
        view.addAnnotation(annotation)
        view.setRegion(region,animated: true)
        
        
     
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 35.69853797637297, longitude: 139.4137812402458))
            //プレビューデバイスを設定するコード
                .previewDevice(PreviewDevice(rawValue:"iPhone 12 Pro Max"))
            
    }
}
