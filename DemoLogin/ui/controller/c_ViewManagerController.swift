//
//  c_ViewManagerController.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2020/5/19.
//  Copyright © 2020 Mark. All rights reserved.
//



public class c_ViewManagerController : SimpleCommand {
    override public func execute(_ notification: INotification) {
        if let proxy = facade.retrieveProxy(p_ViewManagerProxy.NAME) as? p_ViewManagerProxy {
            switch notification.type {

            default:
                break
            }
        }
    }
}
