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

        window?.rootViewController = UIHostingController(rootView: VerticalPagination())
        window?.makeKeyAndVisible()
        
        return true
    }
}
