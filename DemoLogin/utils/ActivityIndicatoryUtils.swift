//
//  ActivityIndicatoryUtils.swift
//  TriggerBangIos
//
//  Created by Mark on 2019/10/16.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatoryUtils : NSObject{
    
    var alertWindow: UIWindow!{
        didSet {
            if alertWindow != nil {
                alertWindow.rootViewController = alertController
                alertWindow.windowLevel = UIWindow.Level.alert + 2;
                alertWindow.backgroundColor = .clear
                //alertWindow.makeKeyAndVisible()
            }
        }
    }
    var alertController:UIViewController!
    //var container: TouchDismissView!
    //var loadingView: UIView!
    var loadingLabel:UILabel!
    var cancelBtn:UIButton!
    var activityIndicator: UIActivityIndicatorView!
    var isShow:Bool!
    var waitForCancelTime:Int = 0
    var countTime = 0
    var timer:SwiftTimer!
    
    private static var instance:ActivityIndicatoryUtils!
    
    public static func sharedInstance() -> ActivityIndicatoryUtils {
        if instance == nil {
            instance = ActivityIndicatoryUtils()
        }
        return instance!
    }
    
    public override init() {
        super.init()

        alertController =  UIViewController.init()
        alertController.view.frame = UIScreen.main.bounds
        
        let container = UIView()
        container.frame = alertController.view.frame
        container.center = alertController.view.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0x000000, alpha: 0.5)
        //container.del = self
    
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = alertController.view.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
    
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingLabel = UILabel()
        loadingLabel.font = UIFont.init(name: "NotoSansCJKjp-Regular", size: 16)
        loadingLabel.text = NSLocalizedString("loading", comment: "")
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .white
        loadingLabel.numberOfLines = 0
        loadingLabel.frame = CGRect.init(x: 0, y: 60, width: container.width, height: 90)
        loadingLabel.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height / 2 + 80)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        cancelBtn.setTitleColor(.init(hex: "FFFFFF"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.init(name: "NotoSansCJKjp-Regular", size: 16)
        cancelBtn.cornerRadius = 24
        cancelBtn.backgroundColor = .init(hex: "707070")
        cancelBtn.frame = CGRect.init(x: 0, y: 60, width: container.width  - 40, height: 48)
        cancelBtn.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height - 80)
        cancelBtn.addTarget(self, action: #selector(onCancelClick), for: .touchUpInside)

        container.addSubview(cancelBtn)
        container.addSubview(loadingLabel)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        alertController.view.addSubview(container)

        self.isShow = false
        timer?.suspend()
        timer = SwiftTimer.init(interval: .seconds(1),repeats: true, handler: { [self] (timer) in
            countTime += 1
            if isShow,waitForCancelTime > 0,countTime>waitForCancelTime,cancelBtn.isHidden == true{
                cancelBtn.isHidden = false
            }
        })
        timer.start()
    }
    
    func showActivityIndicator(waitforCancelTime:Int = 300) {
        //先關閉loading
        deleteActivityIndicator()
        self.isShow = true
        self.waitForCancelTime = waitforCancelTime
        self.countTime = 0
        DispatchQueue.main.async {
            if(self.isShow){
                self.cancelBtn?.isHidden = true
                self.alertWindow?.isHidden = false
                self.activityIndicator?.startAnimating()
            }
        }
    }

    
    func deleteActivityIndicator() {
        isShow = false
        waitForCancelTime = 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            if !self.isShow{
                self.loadingLabel.text = NSLocalizedString("loading", comment: "")
                self.alertWindow?.isHidden = true
                self.activityIndicator?.stopAnimating()
            }
        }
    }

    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func SetLoadingProgress(progress:Int){
        self.loadingLabel?.text = "\(progress)%"
    }
    
    func SetLoadingText(text:String){
        self.loadingLabel?.text = text
    }
    
    @objc func onCancelClick(sender:Any){
        deleteActivityIndicator()
    }
}

