//
//  v_EditMediator.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit


public class v_EditMediator: BaseView, vc_EditDelegate {
   

    var openData:m_LoginModel!
    var status:EditType = .View
    
    enum EditType{
        case View
        case Edit
    }
    
    override public class var NAME: String { return e_EditEvents.NAME }


    init(viewComponent: vc_Edit) {
        super.init(mediatorName: e_EditEvents.NAME, viewComponent: viewComponent)
    }
    
    override public func onRemove() {
        
    }
    
    override public func onRegister() {
    }
    
    func viewDidLoad() {
        if(InitView(obj: nil)){
            CreateView(obj : nil)
        }
    }
    
    override public func listNotificationInterests() -> [String] {
        return [
            e_EditEvents.REGISTER,
            e_EditEvents.OPEN,
            e_EditEvents.CREATE,
            e_EditEvents.CLOSE,
            e_EditEvents.BACK,
            e_EditEvents.SEND_EDIT_RESULT
        ]
    }
    
    override public func handleNotification(_ notification: INotification) {
        switch notification.name {
        case e_EditEvents.REGISTER:
            registerView()
        case e_EditEvents.OPEN:
            OpenView(obj:notification.body, mediatorName: e_EditEvents.NAME, vc: viewController)
        case e_EditEvents.CLOSE:
            CloseView(obj:notification.body, mediatorName: e_EditEvents.NAME)
        case e_EditEvents.BACK:
            BackView(obj:notification.body, mediatorName: e_EditEvents.NAME, vc: viewController)
        case e_EditEvents.SEND_EDIT_RESULT:
            sendEditResult(obj: notification.body)
        default:
            break
        }
    }
    
    private func registerView(){
        viewController.del = self
    }
    
    override public func InitView(obj:Any?) -> Bool {
        super.InitView(obj: obj)
        return true
    }
    override public func CreateView(obj:Any?) -> Bool {
        super.CreateView(obj: obj)
        if let data = openData,let time = data.timezone{
            viewController.timezoneField.text = String(time)
            viewController.userField.text = data.username
        }
        
        setView(type: .View)
        
        return true
    }
    override public func OpenView(obj:Any?, mediatorName: String, vc: UIViewController) -> Bool {
        super.OpenView(obj: obj, mediatorName: mediatorName, vc: vc)
        if let viewData = obj as? m_ViewData,let data = viewData.data as? m_LoginModel{
            openData = data
        }
        
        return true
    }
    override public func BackView(obj:Any?, mediatorName: String, vc: UIViewController) -> Bool {
        super.BackView(obj: obj, mediatorName: mediatorName, vc: vc)
        return true
    }
    override public func CloseView(obj:Any?, mediatorName: String) -> Bool {
        return true
    }
    
    //<<<<< UI -----
    func setView(type:EditType){
        status = type
        if status == .View{
            viewController.navigationItem.rightBarButtonItem = viewController.edit
            viewController.timezoneField.isUserInteractionEnabled = false
        }else{
            viewController.navigationItem.rightBarButtonItem = viewController.save
            viewController.timezoneField.isUserInteractionEnabled = true
        }
    }
    
    func onEditClick() {
        setView(type: .Edit)
    }
    
    func onSaveClick(){
        if let text = viewController.timezoneField.text{
            if text.isInt{
                let num = text.IntValue()
                if num > -12 && num <= 12{
                    setView(type: .View)
                    sendEdit()
                    return
                }
            }
        }
        let controller = UIAlertController(title: "error", message: "wrong value", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        viewController.present(controller, animated: true, completion: nil)
    }
    
    func onBackClick() {
        sendNotification(e_EditEvents.GENERAL_RESULT, body: nil, type: e_EditEvents.BACK)
    }
    
    //----- API >>>>>
    func sendEdit(){
        var dic = [String:Any]()
        dic["timezone"] = viewController.timezoneField.text!.IntValue()
        dic["objectId"] = openData?.objectId ?? ""
        sendNotification(e_EditEvents.GENERAL_RESULT, body: dic, type: e_EditEvents.SEND_EDIT)
    }
    
    func sendEditResult(obj:Any?){
        if let model = obj as? m_EditModel{
            if let error = model.error{
                let controller = UIAlertController(title: "error", message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                viewController.present(controller, animated: true, completion: nil)
                if let time = openData.timezone{
                    viewController.timezoneField.text = String(time)
                }
                return
            }
            
            
        }
    }

    //<<<<< API -----
    
    var viewController: vc_Edit {
        return viewComponent as! vc_Edit
    }
}
