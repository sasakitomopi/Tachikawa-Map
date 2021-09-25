//
//  DengenCafeApp.swift
//  DengenCafe
//
//  Created by user on 2021/08/29.
//

import SwiftUI

@main
struct DengenCafeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HumburgerMenu()
        }
    }
}
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
     
        
        return true
    }
    
    // 必要に応じて処理を追加
}
