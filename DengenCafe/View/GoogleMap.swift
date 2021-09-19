//
//  GoogleMap.swift
//  DengenCafe
//
//  Created by user on 2021/09/09.
//

import SwiftUI

//CoreLocation 現在地の情報を取得するためのフレームワーク
import CoreLocation

//CocoaPodsのフレームワークを使用するためのフレームワーク
import Firebase

//地図を表示するためのフレームワーク
import MapKit

//UIKit(テキストフィールドを作成するためのフレームワーク)
import UIKit

//表示する内容を纏めているクラス
struct GoogleMap: View{
    
    //入るデータによって緯度を経度を変えたいため、ここで定義
    @State var coordinate = CLLocationCoordinate2D()
    @State var coordinate1 = CLLocationCoordinate2D()
    //現在地を取得した際にユーザーから許可をもらうためのプロパティを定義する
    @State var alert = false
    
    var body : some View {
        //このメソッドの使い方がよく分からない
        mapView(coordinate: $coordinate,coordinate1:$coordinate1)
            //.alert(isPresented:)が型
            //これがtrueになったらalertしてくれる
            .alert(isPresented:$alert){

            //ユーザに現在地の情報を取得する許可を求めるAlert(title: Text()を定義している)
            Alert(title: Text("Please Enable Location Access In Setting Panel!!!"))
        }
    }
}

final class MyMapView: MKMapView, CLLocationManagerDelegate ,MKMapViewDelegate{
    private let manager = CLLocationManager()

    func configure(
        coordinate: CLLocationCoordinate2D,
        coordinate1: CLLocationCoordinate2D
    ) {
        let center = coordinate
        let center1 = coordinate1
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let region1 = MKCoordinateRegion(center:center1,latitudinalMeters: 10000,
                                         longitudinalMeters: 10000)
        let pin = MKPointAnnotation()
        let pin1 = MKPointAnnotation()
        
        let coordinate = MKPlacemark(coordinate: coordinate)
        let coordinate1 = MKPlacemark(coordinate: coordinate1)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: coordinate)
        directionRequest.destination = MKMapItem(placemark: coordinate1)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        //responseに配列の要素を渡している
        directions.calculate{(response,error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("we have error getting directions == \(error.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.addOverlay(route.polyline,level: .aboveRoads)
            //縮尺を設定
            let rect = route.polyline.boundingMapRect
            self.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        pin.coordinate = center
        pin1.coordinate = center1
        
        addAnnotation(pin)
        addAnnotation(pin1)
        
        self.region = region
        self.region = region1
        
        //CLLocationManagerDelegateプロトコルを実装するクラスを指定する
        manager.delegate = self
        delegate = self
        
        //Userの現在地をその都度アップデートすることが出来るメソッド
        manager.startUpdatingLocation()
        
        //Userの現在地の情報を表示するためのプロパティ(Bool型)
        showsUserLocation = true
        
        //現在地の取得の許可をUserに対して求めるメソッド
        manager.requestWhenInUseAuthorization()
    }
    
    // MARK: Delegate
    func locationManager(_ manager:CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus){
        if status == .denied{
//            parent.alert.toggle()
            print("denied")
        }
    }
    
    func locationManager(_ manager:CLLocationManager,didUpdateLocations locations: [CLLocation]){
        
        //lastメソッドは配列の一番最後の部分を渡している
        let location = locations.last
        
        configure(coordinate: location!.coordinate, coordinate1: CLLocationCoordinate2D(latitude:37.7917315 , longitude: -122.4169851))
        
        let point = MKPointAnnotation()
        
        //緯度経度から地域名を特定することができるプロパティ
        let georeder = CLGeocoder()

        georeder.reverseGeocodeLocation(location!) {(places,err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let place = places?.first?.locality
            point.title = place
            point.subtitle = "Current Place"
            point.coordinate = location!.coordinate
            self.removeAnnotations(self.annotations)
            self.addAnnotation(point)
            
            let region = MKCoordinateRegion(center: location!.coordinate,latitudinalMeters: 10000,
                                            longitudinalMeters: 10000)
            print(region)
            self.region = region
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
}

//mapViewの作成


//UIKit(MapViewはUIKitの中のフレームワークの一つ)を使用するために定義するプロトコル(約束ごとのようなもの)
struct mapView : UIViewRepresentable {
    //@Bindingを定義した値を変更することで@Stateで定義した値も変更される
    //@Stateで定義した初期値が@Bindingに代入されるため、初期値を代入しなくても良い
    @Binding var coordinate : CLLocationCoordinate2D
    @Binding var coordinate1 : CLLocationCoordinate2D
    
    private let map = MyMapView()
    
    //makeUIView:mapViewの初期値を設定する
    func makeUIView(context:UIViewRepresentableContext<mapView>) -> MKMapView {
        map.configure(coordinate: coordinate, coordinate1: coordinate1)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        map.configure(coordinate: coordinate, coordinate1: coordinate1)
    }
}

//プレビュー画面で実際に表示するクラス
struct GoogleMap_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GoogleMap(coordinate: CLLocationCoordinate2D(latitude: 35.69853797637297, longitude: 139.4137812402458))
            
        }
    }
}
