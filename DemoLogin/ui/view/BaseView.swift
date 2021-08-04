//
//  BaseView.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/12.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

open class BaseView : Mediator {
    
    init(mediatorName: String, viewComponent: UIViewController) {
        super.init(mediatorName: mediatorName, viewComponent: viewComponent)
    }
    open func InitView(obj:Any?) -> Bool {
        return true
    }
    open func CreateView(obj:Any?) -> Bool {
        return true
    }
    open func OpenView(obj:Any?, mediatorName: String, vc: UIViewController) -> Bool {
        if var data = obj as? m_ViewData {
            data.vc = vc
            v_ViewManagerMediator.sharedInstance.addViewList(data: data)
        }
        return true
    }
    open func BackView(obj:Any?, mediatorName: String, vc: UIViewController) -> Bool {
        if var data = obj as? m_ViewData {
            data.vc = vc
            v_ViewManagerMediator.sharedInstance.addViewList(data: data)
        }
        return true
    }
    open func CloseView(obj:Any?, mediatorName: String) -> Bool {
        return true
    }
}
