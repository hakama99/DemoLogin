//
//  v_LoginMediator.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit


public class v_LoginMediator: BaseView, vc_LoginDelegate {

    override public class var NAME: String { return e_LoginEvents.NAME }


    init(viewComponent: vc_Login) {
        super.init(mediatorName: e_LoginEvents.NAME, viewComponent: viewComponent)
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
            e_LoginEvents.REGISTER,
            e_LoginEvents.OPEN,
            e_LoginEvents.CREATE,
            e_LoginEvents.CLOSE,
            e_LoginEvents.BACK,
            e_LoginEvents.SEND_LOGIN_RESULT
        ]
    }
    
    override public func handleNotification(_ notification: INotification) {
        switch notification.name {
        case e_LoginEvents.REGISTER:
            registerView()
        case e_LoginEvents.OPEN:
            OpenView(obj:notification.body, mediatorName: e_LoginEvents.NAME, vc: viewController)
        case e_LoginEvents.CLOSE:
            CloseView(obj:notification.body, mediatorName: e_LoginEvents.NAME)
        case e_LoginEvents.BACK:
            BackView(obj:notification.body, mediatorName: e_LoginEvents.NAME, vc: viewController)
        case e_LoginEvents.SEND_LOGIN_RESULT:
            sendLoginResult(obj: notification.body)
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
        return true
    }
    override public func OpenView(obj:Any?, mediatorName: String, vc: UIViewController) -> Bool {
        super.OpenView(obj: obj, mediatorName: mediatorName, vc: vc)
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
    
    func onLoginClick() {
        if !viewController.accountTextField.text!.isEmpty && !viewController.passwordTextfield.text!.isEmpty{
            sendLogin()
        }else{
            let controller = UIAlertController(title: "error", message: "Please input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    //----- API >>>>>
    func sendLogin(){
        var dic = [String:String]()
        dic["username"] = viewController.accountTextField.text!
        dic["password"] = viewController.passwordTextfield.text!
        sendNotification(e_LoginEvents.GENERAL_RESULT, body: dic, type: e_LoginEvents.SEND_LOGIN)
    }
    
    func sendLoginResult(obj:Any?){
        if let model = obj as? m_LoginModel{
            if let error = model.error{
                    print("login fail:\(error)")
                    let controller = UIAlertController(title: "error", message: error, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    controller.addAction(okAction)
                    viewController.present(controller, animated: true, completion: nil)
                return
            }
            
            if let token = model.sessionToken{
                ApiManager.Instance().ToKen = token
            }
            sendNotification(e_LoginEvents.GENERAL_RESULT,body: model,type: e_LoginEvents.OPEN_EDIT)
        }
    }

    //<<<<< API -----
    
    var viewController: vc_Login {
        return viewComponent as! vc_Login
    }
}
