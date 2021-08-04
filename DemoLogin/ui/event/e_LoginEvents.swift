//
//  e_LoginEvents.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

public class e_LoginEvents {
    
    // 命名規則 : 類型 + 動作
    public static let NAME : String = "login"
    public static let GENERAL_RESULT : String = "\(NAME)_general_result"
    public static let REGISTER : String = "\(NAME)_register"
    public static let OPEN : String = "\(NAME)_open"
    public static let CLOSE : String = "\(NAME)_close"
    public static let CREATE : String = "\(NAME)_create"
    public static let DESTROY : String = "\(NAME)_destroy"
    public static let BACK : String = "\(NAME)_back"
    
    public static let OPEN_EDIT : String = "\(NAME)_open_edit"
    
    public static let SEND_LOGIN : String = "\(NAME)_send_login"
    public static let SEND_LOGIN_RESULT : String = "\(NAME)_send_login_result"
}
