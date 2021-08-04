//
//  AppDelegate.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/7.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UISceneDelegate {
    
    var window: UIWindow?
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    //IOS13以下初始化
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startFacade()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("sceneDidBecomeActive")
    }
    
    func startFacade(scene:Any? = nil){
        let scenesView = UIStoryboard(name: "Launch", bundle: nil)
        let controller = scenesView.instantiateViewController(withIdentifier: e_ViewManagerEvents.NAME)
        window = UIWindow()
        if #available(iOS 13.0, *), let sc = scene as? UIWindowScene{
            window = UIWindow(windowScene: sc)
            ActivityIndicatoryUtils.sharedInstance().alertWindow = UIWindow(windowScene: sc)
        } else {
            window = UIWindow()
            ActivityIndicatoryUtils.sharedInstance().alertWindow = UIWindow()
        }
        window?.makeKeyAndVisible()
        window?.rootViewController = controller
        
        
        UIFacade.getInstance().startup(self)
    }
}
