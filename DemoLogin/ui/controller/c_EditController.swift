//
//  c_EditController.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//



public class c_EditController : SimpleCommand {
    override public func execute(_ notification: INotification) {
        if let proxy = facade.retrieveProxy(p_EditProxy.NAME) as? p_EditProxy {
            switch notification.type {
            case e_EditEvents.BACK:
                proxy.OnBackClick(obj: notification.body)
                
            case e_EditEvents.SEND_EDIT:
                proxy.SendEdit(obj: notification.body)
            default:
                break
            }
        }
    }
}
