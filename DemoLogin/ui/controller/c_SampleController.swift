//
//  c_SampleController.swift
//  OpusOrbis
//
//  Created by System Administrator on 2019/11/14.
//  Copyright © 2019 Mark. All rights reserved.
//




public class c_SampleController : SimpleCommand {
    override public func execute(_ notification: INotification) {
        if let proxy = facade.retrieveProxy(p_SampleProxy.NAME) as? p_SampleProxy {
            switch notification.type {
            case e_SampleEvents.BACK_VIEW:
                proxy.OnBackClick(obj: notification.body)
            default:
                break
            }
        }
    }
}
