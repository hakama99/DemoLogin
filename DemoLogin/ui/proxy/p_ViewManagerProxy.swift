//
//  p_ViewManagerProxy.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2020/5/19.
//  Copyright © 2020 Mark. All rights reserved.
//


public class p_ViewManagerProxy : BaseProxy {
    
    override public class var NAME: String { return "p_ViewManagerProxy" }
    private var showLog:Bool = false
    
    init() {
        super.init(proxyName: p_ViewManagerProxy.NAME)
    }
    
}
