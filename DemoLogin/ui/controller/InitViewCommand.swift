//
//  InitViewCommand.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/8.
//  Copyright © 2019 Mark. All rights reserved.
//


public class InitViewCommand : SimpleCommand {
    
    override public func execute(_ notification: INotification) {
        facade.registerMediator(v_UnitTestMediator(viewComponent: vc_UnitTest()))
        facade.registerMediator(v_LoginMediator(viewComponent: vc_Login()))
        facade.registerMediator(v_EditMediator(viewComponent: vc_Edit()))
    }
}
