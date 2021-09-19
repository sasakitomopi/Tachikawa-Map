//
//  ModelData.swift
//  DengenCafe
//
//  Created by user on 2021/09/02.
//

import Foundation

//jsonファイルを読み込む
//以下のload関数を読み込んでいる
var landmarks :[Landmark] = load("dengenCafe.json")

func load<T: Decodable>(_ filename:String) ->T{
    let data:Data
    
    //❶プロジェクト内のjsonファイルがBundle.mainに存在するかを確認する作業
    guard let url = Bundle.main.url(forResource:filename,withExtension: nil)else{
        fatalError("ファイルが見つからない")
    }
    
    do{
        data = try Data(contentsOf: url)
    }catch{
        fatalError("データ読み込みエラー")
    }
    
    //❸JSONデコード処理を行う
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch{
        fatalError("JSON読み込みエラー")
    }
}

