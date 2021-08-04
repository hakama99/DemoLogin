//
//  c_GeneralController.swift
//  OpusOrbis
//
//  Created by System Administrator on 2019/11/14.
//  Copyright © 2019 Mark. All rights reserved.
//




public class c_GeneralController : SimpleCommand {
    override public func execute(_ notification: INotification) {
        if let proxy = facade.retrieveProxy(p_GeneralProxy.NAME) as? p_GeneralProxy {
            switch notification.type {

            default:
                break
            }
        }
    }
}
