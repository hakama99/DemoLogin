//
//  LogUtil.swift
//  OpusOrbis
//
//  Created by mark on 2020/1/13.
//  Copyright © 2020 Mark. All rights reserved.
//



public class LogUtil {
    private var _isShowLog:Bool!
    private static var _singleInstance:LogUtil!
    
    public static func GetSingleInstance() -> LogUtil {
        if(_singleInstance == nil){
            _singleInstance = LogUtil()
        }
        return _singleInstance
    }
    
    init() {
        _isShowLog = false
    }
    
    public func SetIsShowLog(isShowLog:Bool){
        _isShowLog = isShowLog
    }
    
    public func ShowLog(tag:String, msg:String){
        print("\(tag) \(msg)")
    }
    
    
    public func ShowLog(tag:String, msg:Any){
        print("\(tag) \(msg)")
    }
}
