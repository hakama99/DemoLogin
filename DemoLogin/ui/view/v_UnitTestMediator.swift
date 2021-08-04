//
//  v_UnitTestMediator.swift
//  OpusOrbis
//
//  Created by mark on 2019/11/21.
//  Copyright © 2019 Mark. All rights reserved.
//


import UIKit


public class v_UnitTestMediator: BaseView, vc_UnitTestDelegate {

    override public class var NAME: String { return e_UnitTestEvents.NAME }
        
    init(viewComponent: vc_UnitTest) {
        super.init(mediatorName: e_UnitTestEvents.NAME, viewComponent: viewComponent)
    }
    
    override public func onRemove() {
        
    }
    
    override public func onRegister() {
    }
    
    func viewDidLoad() {
        InitView(obj: nil)
    }
    
    override public func listNotificationInterests() -> [String] {
        return [
            e_UnitTestEvents.OPEN
        ]
    }
    
    override public func handleNotification(_ notification: INotification) {
        switch notification.name {
        case e_UnitTestEvents.OPEN:
            OpenView(obj:notification.body, mediatorName: e_UnitTestEvents.NAME, vc: viewController)
        default:
            break
        }
    }
    
    private func registerView(){
        viewController.delegate = self
    }
    
    override public func OpenView(obj:Any?, mediatorName: String, vc: UIViewController) -> Bool {
        super.OpenView(obj: obj, mediatorName: mediatorName, vc: vc)
        return true
    }
    
    var viewController: vc_UnitTest {
        return viewComponent as! vc_UnitTest
    }
}
