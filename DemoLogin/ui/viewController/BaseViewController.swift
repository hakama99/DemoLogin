//
//  BaseViewController.swift
//  TriggerBangIos
//
//  Created by CE on 2019/10/29.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController{
    
    override public var shouldAutorotate: Bool{
        return false
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
        super.dismiss(animated: flag, completion: completion)
    }
    
}
