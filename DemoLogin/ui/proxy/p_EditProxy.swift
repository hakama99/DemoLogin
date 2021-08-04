//
//  p_EditProxy.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

public class p_EditProxy : BaseProxy {
    
    override public class var NAME: String { return "p_EditProxy" }
    private var showLog:Bool = false
    
    init() {
        super.init(proxyName: p_EditProxy.NAME)
    }
    
    public func OnBackClick(obj:Any?){
        sendNotification(e_ViewManagerEvents.OPEN_PREV_VIEW)
    }
        
    public func SendEdit(obj:Any?){
        if let data = obj as? [String:Any],let objectId = data["objectId"] as? String,let timezone = data["timezone"]{
            var para = [String:Any]()
            para["timezone"] = timezone
            ApiManager.Instance().sendApiByPost(url: ApiPath.Edit.rawValue + objectId, para: para, complete: sendEditResult(data:error:))
        }
    }
    
    func sendEditResult(data:Data?,error:Error?){
        var model = m_EditModel.init()
        let decoder = JSONDecoder()

        if let jsonData = data {

            do {
                model = try decoder.decode(m_EditModel.self, from: jsonData)
                print("model:\(model)")
            } catch {
                print("error:\(error)")
            }
        }
        

        sendNotification(e_EditEvents.SEND_EDIT_RESULT, body: model)
    }
}
