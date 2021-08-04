//
//  ImagePickerComponent.swift
//  TriggerBangIos
//
//  Created by CE on 2019/9/5.
//  Copyright © 2019 Mark. All rights reserved.
//

import CoreLocation
import UIKit

public class GetLocationStatus{
    
    static func GetWhenInUseStatus(manager:CLLocationManager, view:UIViewController,completion:@escaping((_ success:Bool)->Void) ){
        let status = CLLocationManager.authorizationStatus()
        if (status == .authorizedWhenInUse || status == .authorizedAlways ) {
            completion(true)
        }
        else if (status == .restricted || status == .denied) {
            let alert = UIAlertController(title: "允許取用位置", message: "若要分享您的所在地點，我們需要收集您的地點資訊，請前往設定", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "設定", style: .default, handler:{(_)-> Void in
                completion(false)
                if let setting = URL(string: UIApplication.openSettingsURLString){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(setting, completionHandler: {(sucess) in
                            //print(sucess)
                        })
                    } else {
                        UIApplication.shared.openURL(setting)
                    }
                }
            })
            let action2 = UIAlertAction(title: "稍後再說", style: .default, handler:{(_)->Void in
                completion(false)
            })
            alert.addAction(action2)
            alert.addAction(action1)
            view.present(alert ,animated: true,completion: nil)
            
        }
        else if (status == .notDetermined) {//首次使用
            manager.requestAlwaysAuthorization()
            //如果使用者允許 locationManager.startUpdateingLocation()會開始回傳位置
            completion(true)
  
        }else{
            completion(false)
        }
    }
    
    
    static func GetAlwaysStatus(manager:CLLocationManager,view:UIViewController,completion:@escaping((_ success:Bool)->Void) ){
        let status = CLLocationManager.authorizationStatus()
        if (status == .authorizedAlways) {
            completion(true)
        }
        else if (status == .restricted || status == .denied || status == .authorizedWhenInUse) {
            
            let alert = UIAlertController(title: "允許取用照片", message: "若要上傳照片，我們需要取用您的照片，請前往設定", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "設定", style: .default, handler:{(_)-> Void in
                completion(false)
                if let setting = URL(string: UIApplication.openSettingsURLString){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(setting, completionHandler: {(sucess) in
                            //print(sucess)
                        })
                    } else {
                        UIApplication.shared.openURL(setting)
                    }
                }
            })
            let action2 = UIAlertAction(title: "稍後再說", style: .default, handler:{(_)->Void in
                completion(false)
            })
            alert.addAction(action2)
            alert.addAction(action1)
            view.present(alert ,animated: true,completion: nil)
            
        }
        else if (status == .notDetermined) {//首次使用
            manager.requestAlwaysAuthorization()
            //locationManager.requestAlwaysAuthorization()()
            //如果使用者允許 locationManager.startUpdateingLocation()會開始回傳位置
            completion(true)
        }else{
            completion(false)
        }
    }
}
