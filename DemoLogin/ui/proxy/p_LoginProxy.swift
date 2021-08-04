//
//  p_LoginProxy.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

public class p_LoginProxy : BaseProxy {
    
    override public class var NAME: String { return "p_LoginProxy" }
    private var showLog:Bool = false
    
    init() {
        super.init(proxyName: p_LoginProxy.NAME)
    }
    
    
    public func OpenEdit(obj:Any?){
        let viewData = m_ViewData(
            sbname: "Login",
            sbid: e_EditEvents.NAME,
            animation: "left_push",
            data: obj
        )
        sendNotification(e_ViewManagerEvents.OPEN_NEXT_VIEW, body: viewData)
    }
        
    public func SendLogin(obj:Any?){
        if let data = obj as? [String:String]{
            ApiManager.Instance().sendApi(url: ApiPath.Login.rawValue, para: data, complete: sendLoginResult(data:error:))
        }
    }
    
    func sendLoginResult(data:Data?,error:Error?){
        var model = m_LoginModel.init()
        let decoder = JSONDecoder()

        if let jsonData = data {

            do {
                model = try decoder.decode(m_LoginModel.self, from: jsonData)
                print("model:\(model)")
            } catch {
                print("error:\(error)")
            }
        }
        

        sendNotification(e_LoginEvents.SEND_LOGIN_RESULT, body: model)
    }
}
