//
//  BaseProxy.swift
//  TriggerBangIos
//
//  Created by Mark on 2019/9/12.
//  Copyright © 2019 Mark. All rights reserved.
//



public class BaseProxy : Proxy {
    
    private var isShowLog:Bool = true
    
    // the proxy name
    fileprivate var _proxyName: String
    
    // the data object
    fileprivate var _data: Any?
    
    public override init(proxyName: String?=nil, data: Any?=nil) {
        _proxyName = proxyName ?? BaseProxy.NAME
        _data = data
        super.init(proxyName: _proxyName)
    }
    
    private func showLog(msg:String){
        if(isShowLog){
            print("[BaseProxy] \(msg)")
        }
    }
}



