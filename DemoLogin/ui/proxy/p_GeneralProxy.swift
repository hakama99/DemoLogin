//
//  p_BookingProxy.swift
//  OpusOrbis
//
//  Created by System Administrator on 2019/11/14.
//  Copyright © 2019 Mark. All rights reserved.
//



public class p_GeneralProxy : BaseProxy {
    
    override public class var NAME: String { return "p_GeneralProxy" }
    private var showLog:Bool = false
    var dic=Dictionary<String, String>()
    
    init() {
        super.init(proxyName: p_GeneralProxy.NAME)
    }
}
