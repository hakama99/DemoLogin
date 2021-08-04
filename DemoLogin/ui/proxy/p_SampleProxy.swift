//
//  p_SampleProxy.swift
//  OpusOrbis
//
//  Created by System Administrator on 2019/11/14.
//  Copyright © 2019 Mark. All rights reserved.
//



public class p_SampleProxy : BaseProxy {
    
    override public class var NAME: String { return "p_SampleProxy" }
    private var showLog:Bool = false
    
    init() {
        super.init(proxyName: p_SampleProxy.NAME)
    }
    
    public func OnBackClick(obj:Any?){
        sendNotification(e_ViewManagerEvents.OPEN_PREV_VIEW)
    }
}

