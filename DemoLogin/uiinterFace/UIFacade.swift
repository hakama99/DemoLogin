//
//  UIFacade.swift
//  TriggerBangIos
//
//  Created by Mark on 2019/8/30.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

public class UIFacade : Facade {
    
    /**
     Register Commands with the Controller
     */
    override public func initializeController() {
        super.initializeController()
        registerCommand(e_ViewManagerEvents.START_UP) { StartupCommand() }
        registerCommand(e_ViewManagerEvents.GENERAL_RESULT) { c_ViewManagerController() }
        registerCommand(e_SampleEvents.GENERAL_RESULT) { c_SampleController() }
        registerCommand(e_GeneralEvents.GENERAL_RESULT) { c_GeneralController() }
        registerCommand(e_LoginEvents.GENERAL_RESULT) { c_LoginController() }
        registerCommand(e_EditEvents.GENERAL_RESULT) { c_EditController() }
    }
    
    /**
     Singleton Factory Method
     */
    class func getInstance() -> UIFacade {
        return super.getInstance { UIFacade() } as! UIFacade
    }
    
    /**
     Start the application
     */
    func startup(_ appDelegate: AppDelegate) {
        registerMediator(v_ViewManagerMediator(mediatorName : e_ViewManagerEvents.NAME, viewComponent: vc_ViewManager()))
        sendNotification(e_ViewManagerEvents.START_UP, body: appDelegate)
    }
}
