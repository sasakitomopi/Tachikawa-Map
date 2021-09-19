//
//  Landmark.swift
//  DengenCafe
//
//  Created by user on 2021/08/30.
//

import SwiftUI
//位置情報を取得するために必要なパッケージ
import CoreLocation

//Modelのデータを読み込んだりすることを可能にするパッケージ
import Foundation

//枠組みを作るときにはstructで定義をする
//それ以外に関しては変数：型
//または、変数:型()
struct Landmark:Codable,Hashable,Identifiable{
    //変数がvarで定数がlet
    
    //jsonファイルのid
    var id :Int
    
    //jsonファイルのcategory
    var category:String
    //jsonファイルのname
    var name :String
    //jsonファイルのsubName
    var subName:String
    //jsonファイルのcity
    var city:String
    //jsonファイルのisFeatured
    var isFeatured:Bool
    
    //jsonファイルのlink
    var link:String
    
    //jsonファイルのimageName
    //なぜ一旦String型で拾ってきてから、Image型のimage変数に代入するのか
    var imageName :String
    var image:Image{
        Image(imageName)
    }
    
    
    //jsonファイルのcoordinates
    private var coordinates:Coordinates
    var locationCoordinates:CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    //Coordinatesの型の宣言
    struct Coordinates:Hashable,Codable{
        var latitude: Double
        var longitude:Double
    
    }
}
