//
//  InitProxyCommand.swift
//  TriggerBangIos
//
//  Created by Mark on 2019/8/30.
//  Copyright © 2019 Mark. All rights reserved.
//

public class InitProxyCommand : SimpleCommand {
    
    override public func execute(_ notification: INotification) {
        facade.registerProxy(p_ViewManagerProxy())
        facade.registerProxy(p_LoginProxy())
        facade.registerProxy(p_GeneralProxy())
        facade.registerProxy(p_LoginProxy())
        facade.registerProxy(p_EditProxy())
    }
}
