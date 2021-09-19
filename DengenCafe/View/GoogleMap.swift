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
    //CLLocationManager CoreLocationフレームワークにあるプロパティのこと
    @State var manager = CLLocationManager()
    
    //入るデータによって緯度を経度を変えたいため、ここで定義
    @State var map = MKMapView()
    
    @State var coordinate = CLLocationCoordinate2D()
    @State var coordinate1 = CLLocationCoordinate2D()
    //現在地を取得した際にユーザーから許可をもらうためのプロパティを定義する
    @State var alert = false
    
    var body : some View {
        //このメソッドの使い方がよく分からない
        mapView(manager:$manager,alert:$alert,map: $map,coordinate: $coordinate,coordinate1:$coordinate1)
            //.alert(isPresented:)が型
            //これがtrueになったらalertしてくれる
            .alert(isPresented:$alert){
            
            //ユーザに現在地の情報を取得する許可を求めるAlert(title: Text()を定義している)
            Alert(title: Text("Please Enable Location Access In Setting Panel!!!"))
            
        }
    }
}

//mapViewの作成


//UIKit(MapViewはUIKitの中のフレームワークの一つ)を使用するために定義するプロトコル(約束ごとのようなもの)
struct mapView : UIViewRepresentable {
    //@Bindingを定義した値を変更することで@Stateで定義した値も変更される
    //@Stateで定義した初期値が@Bindingに代入されるため、初期値を代入しなくても良い
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var map : MKMapView
    @Binding var coordinate : CLLocationCoordinate2D
    @Binding var coordinate1 : CLLocationCoordinate2D
    
    
    let textField = UITextField()
    
    //makeCoordinator:Viewの変更をSwiftUI側に通知するためのCoordinatorをインスタンス化するもの
    func makeCoordinator() -> mapView.Coordinator {
        return mapView.Coordinator(parent1 : self)
    }
    
    //makeUIView:mapViewの初期値を設定する
    func makeUIView(context:UIViewRepresentableContext<mapView>) -> MKMapView {
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
            map.addOverlay(route.polyline,level: .aboveRoads)
            //縮尺を設定
            let rect = route.polyline.boundingMapRect
            map.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        
        
        pin.coordinate = center
        pin1.coordinate = center1
        
        map.addAnnotation(pin)
        map.addAnnotation(pin1)
        
        map.region = region
        map.region = region1
        
        
        //CLLocationManagerDelegateプロトコルを実装するクラスを指定する
        manager.delegate = context.coordinator
        
        //Userの現在地をその都度アップデートすることが出来るメソッド
        manager.startUpdatingLocation()
        
        //Userの現在地の情報を表示するためのプロパティ(Bool型)
        map.showsUserLocation = true
        
        //現在地の取得の許可をUserに対して求めるメソッド
        manager.requestWhenInUseAuthorization()
        
        //map(地図の情報を戻り値として返す)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
    }
    
    //makeCoordinaterで返すparent1の中身を定義している
    class Coordinator:NSObject,CLLocationManagerDelegate {
        
        //mapViewのフレームワークをparent変数に格納する
        var parent : mapView
        
        //parentを初期化する(init)
        init(parent1 : mapView) {
            parent = parent1
        }
        
        
        func locationManager(_ manager:CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus){
            
            if status == .denied{
                parent.alert.toggle()
                print("denied")
            }
        }
        
        func locationManager(_ manager:CLLocationManager,didUpdateLocations locations: [CLLocation]){
            
            //lastメソッドは配列の一番最後の部分を渡している
            let location = locations.last
            
            let point = MKPointAnnotation()
            
            //緯度経度から地域名を特定することができるプロパティ
            let georeder = CLGeocoder()
            let handler: ([CLPlacemark]?, Error?) -> Void = { places, error in
            }
            georeder.reverseGeocodeLocation(location!, completionHandler: handler)
            georeder.reverseGeocodeLocation(location!, completionHandler: { places, error in
            })
            georeder.reverseGeocodeLocation(location!) { places, error in
            }
            
            georeder.reverseGeocodeLocation(location!) {(places,err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current Place"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                
                let region = MKCoordinateRegion(center: location!.coordinate,latitudinalMeters: 10000,
                                                longitudinalMeters: 10000)
                print(region)
                self.parent.map.region = region
            }
        }
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
