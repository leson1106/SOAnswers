//
//  AppDelegate.swift
//  MyAnswer
//
//  Created by Son Le on 06/07/2023.
//


import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = UIHostingController(rootView: GridMockItem(items: MockData.createElements()))
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}
