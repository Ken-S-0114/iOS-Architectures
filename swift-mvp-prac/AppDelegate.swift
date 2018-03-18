//
//  AppDelegate.swift
//  swift-mvp-prac
//
//  Created by 佐藤賢 on 2018/03/19.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let app = EntryPoint()
    let vc = app.main()
    let nc = UINavigationController(rootViewController: vc)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = nc
    window?.makeKeyAndVisible()
    
    return true
  }
}

