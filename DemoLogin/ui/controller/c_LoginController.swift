//
//  c_LoginController.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//



public class c_LoginController : SimpleCommand {
    override public func execute(_ notification: INotification) {
        if let proxy = facade.retrieveProxy(p_LoginProxy.NAME) as? p_LoginProxy {
            switch notification.type {
            case e_LoginEvents.OPEN_EDIT:
                proxy.OpenEdit(obj: notification.body)
            
            case e_LoginEvents.SEND_LOGIN:
                proxy.SendLogin(obj: notification.body)
            default:
                break
            }
        }
    }
}
