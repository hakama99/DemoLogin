//
//  viewManagerMediator.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/8.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

import CoreLocation

public class v_ViewManagerMediator: BaseView {
    
    private let _ANIMATION_SPEED:Double = 0.4
    override public class var NAME: String { return e_ViewManagerEvents.NAME }
    
    static var sharedInstance:v_ViewManagerMediator!
    private var rootVC:UIViewController!
    var viewList:[m_ViewData]!
    var tempViewList:[m_ViewData]!
    var isUiLoading:Bool!
    var timer: Timer!
    var autoLogin:Bool = false
    var location:CLLocationManager!
        
    override init(mediatorName : String, viewComponent: UIViewController) {
        super.init(mediatorName: mediatorName, viewComponent: viewComponent)
        v_ViewManagerMediator.sharedInstance = self
        viewList = []
        tempViewList = []
        isUiLoading = false
    }
    
    override public func listNotificationInterests() -> [String] {
        return [
            e_ViewManagerEvents.START_UP,
            e_ViewManagerEvents.OPEN_NEXT_VIEW,
            e_ViewManagerEvents.OPEN_PREV_VIEW,
            e_ViewManagerEvents.OPEN_ROOT_VIEW,
            e_ViewManagerEvents.REMOVE_VIEW,
        ]
    }
    
    override public func handleNotification(_ notification: INotification) {
        switch notification.name {
        case e_ViewManagerEvents.START_UP:
            startup(obj:notification.body)
        case e_ViewManagerEvents.OPEN_NEXT_VIEW:
            OpenNextView(obj: notification.body)
        case e_ViewManagerEvents.OPEN_ROOT_VIEW:
            OpenRootView(obj: notification.body)
        case e_ViewManagerEvents.OPEN_PREV_VIEW:
            OpenPrevView(obj: notification.body)
        case e_ViewManagerEvents.REMOVE_VIEW:
            if let sbid = notification.body as? String{
                removeView(sbid: sbid)
            }
        default:
            break
        }
    }
    
    private func startup(obj: Any?){
        if let app = obj as? AppDelegate,let window = app.window {
            rootVC = window.rootViewController
            timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(v_ViewManagerMediator.timeOut), userInfo: nil, repeats: false)
            /*
            var viewData:m_ViewData!
            let mode = UIApplication.shared.plist("AppMode")
            if(mode == "test"){
                viewData = m_ViewData(
                    sbname: "UnitTest",
                    sbid: e_UnitTestEvents.NAME,
                    animation:
                        e_ViewManagerEvents.DIRECTION_NONE,
                    data: []
                )
                sendNotification(e_ViewManagerEvents.OPEN_ROOT_VIEW, body: viewData)
            }else if(mode == "official" || mode == "develop"){



                timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(v_ViewManagerMediator.timeOut), userInfo: nil, repeats: false)
            }else{
                print("[\(self.mediatorName)] Error - 無開啟畫面 mode: \(mode)")
            }*/
        }
    }
    
    @objc func timeOut(){
        //開啟第一個畫面
        //GlobalData.UID = "5"
        let viewData:m_ViewData = m_ViewData(
            sbname: "Login",
            sbid: e_LoginEvents.NAME,
            animation: e_ViewManagerEvents.DIRECTION_NONE,
            data: nil
        )
        sendNotification(e_ViewManagerEvents.OPEN_ROOT_VIEW, body: viewData)
        
        timer?.invalidate()
        timer = nil
    }
    
    func OpenNextView(obj:Any?){
        //print("OpenNextView")
        if let openData=obj as? m_ViewData{
            
            var isHave = false
            if(viewList != nil && viewList.count > 0){
                for i in 0..<viewList.count {
                    if(viewList != nil && viewList[i].sbid == openData.sbid){
                        isHave = true
                        break
                    }
                }
            }
            //print("OpenNextView\(isHave)")
            DispatchQueue.main.async { [self] in
                if isHave{
                    //非目前開啟的話 關閉之後的畫面
                    if(openData.sbid != (viewList.last?.sbid)) {
                        while let sbid = viewList.last?.sbid,
                            sbid != openData.sbid{
                            removeView(sbid: sbid)
                        }
                    }
                    //print("OpenNextView\(openData.sbid)")
                    //返回該頁
                    let sbid = openData.sbid
                    if let view = viewList.last?.vc{
                        setDismissAnimation(animation: openData.animation, vc: view)
                        sendNotification(view.restorationIdentifier! + "_back", body: obj)
                    }
                    //sendNotification(sbid + e_ViewManagerEvents.OPEN_VIEW,body: openData)
                }else{
                    let sbid = openData.sbid
                    let strory = UIStoryboard(name: openData.sbname, bundle: nil)
                    let view = strory.instantiateViewController(withIdentifier:sbid )
                    var mediator = UIFacade.getInstance().retrieveMediator(sbid)
                    mediator?.viewComponent = view
                    sendNotification(sbid + e_ViewManagerEvents.REGISTER)
                    sendNotification(sbid + e_ViewManagerEvents.OPEN_VIEW,body: openData)
                    setAnimation(animation: openData.animation, vc: view)
                    //addViewList(data: openData)
                }
            }
        }
    }
    
    func OpenRootView(obj:Any?){
        if let openData=obj as? m_ViewData{
            while viewList.count>0,
                let sbid = viewList.last?.sbid{
                removeView(sbid: sbid)
            }
            
            let sbid = openData.sbid
            let strory = UIStoryboard(name: openData.sbname, bundle: nil)
            let view = strory.instantiateViewController(withIdentifier:sbid )
            var mediator = UIFacade.getInstance().retrieveMediator(sbid)
            mediator?.viewComponent = view
            sendNotification(sbid + e_ViewManagerEvents.REGISTER)
            sendNotification(sbid + e_ViewManagerEvents.OPEN_VIEW,body: openData)
            setRootAnimation(animation: openData.animation, vc: view)
        }else{
            if viewList.count>1{
                while viewList.count>1,
                    let sbid = viewList.last?.sbid{
                    removeView(sbid: sbid)
                }
            
                
                var animation = ""
                if let openData=obj as? m_ViewData{
                    animation = openData.animation
                }
                if var present = rootVC.presentedViewController{
                    setRootAnimation(animation: animation, vc: rootVC)
                }
                if let view = rootVC.navigationController{
                    view.popToRootViewController(animated: false)
                    sendNotification(view.restorationIdentifier! + "_back", body: obj)
                }
            }
        }
    }
    
    func OpenPrevView(obj:Any?){
        guard let viewData = viewList.last else {
            print("none view in viewlist")
            return
        }
        //print("OpenPrevView\(viewData)")
        var animation = viewData.animation
        if let openData = obj as? m_ViewData{
            if !openData.animation.isEmpty{
                animation = openData.animation
            }
        }
        removeView(sbid: viewData.sbid)
        //print("OpenPrevView viewList.last\(viewList.last)")
        while viewList.count>0,
            let sbid = viewList.last?.sbid,
            ignoreList(name: sbid){
            removeView(sbid: sbid)
        }
        guard let openView = viewList.last else {
            print("none view in viewlist")
            return
        }
        //print("openView\(openView.sbid)")
        //print("rootVC.restorationIdentifier\(rootVC.restorationIdentifier)")
        if var preVC = rootVC.presentedViewController{
            while preVC.restorationIdentifier != openView.sbid{
                if let child = preVC.presentedViewController{
                    preVC = child
                }else{
                    break;
                }
            }
            //print("preVC.restorationIdentifier\(preVC.restorationIdentifier)")
            //preVC.dismiss(animated: true, completion: nil)
            setDismissAnimation(animation: animation, vc: preVC)
            sendNotification(preVC.restorationIdentifier! + "_back", body: obj)
        }else{
            if let control = rootVC.navigationController{
                var index = -1
                var isHave = false
                for i in 0..<control.viewControllers.count{
                    if control.viewControllers[i].restorationIdentifier == openView.sbid{
                        isHave=true
                        index=i
                    }
                }
                if isHave && index>=0{
                    let preVC = control.viewControllers[index-1 > 0 ? index-1 : 0]
                    setDismissAnimation(animation: animation, vc: preVC)
                    sendNotification(preVC.restorationIdentifier! + "_back", body: obj)
                }else{
                    print("目前是最後一層無法回去1")
                }
            }else{
                print("目前是最後一層無法回去2")
            }
        }
    }
    
    func ignoreList(name:String)->Bool{
        switch name {

        default:
            return false
        }
    }

    
    private func setDismissAnimation(animation: String, vc: UIViewController){
        //print("setDismissAnimation\(vc)")
        var split = animation.components(separatedBy: "_")
        var style = ""
        
        var direction = ""
        if split.count>1{
            direction = split[0]
            style = split[1]
        }
        
        let isAnimation = direction.isEmpty
        let wnd = UIApplication.shared.keyWindow
        wnd?.layer.removeAnimation(forKey: kCATransition)
        if !direction.isEmpty{
            let transition = CATransition()
            transition.duration = _ANIMATION_SPEED
            transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
            transition.type = CATransitionType.push
            switch direction {
            case "left":
                transition.subtype = CATransitionSubtype.fromRight
            case "right":
                transition.subtype = CATransitionSubtype.fromLeft
            case "top":
                transition.subtype = CATransitionSubtype.fromBottom
            case "bottom":
                transition.subtype = CATransitionSubtype.fromTop
            default:
                transition.type = CATransitionType.fade
                transition.subtype = nil
                break;
            }
            wnd?.layer.add(transition, forKey: kCATransition)
        }
        
        DispatchQueue.main.async { [weak self] in
            switch style {
            case "push":
                if var root = self?.rootVC.presentedViewController{
                    //先排除present才能pop
                    while let parent : UIViewController = root.presentingViewController {
                        root = parent
                    }
                    root.dismiss(animated: true, completion: nil)
                    if let control = self?.rootVC.navigationController{
                        control.popToViewController(vc, animated: false)
                    }else{
                        vc.dismiss(animated: false, completion: nil)
                    }
                }else{
                    if let control = self?.rootVC.navigationController{
                        control.popToViewController(vc, animated: true)
                    }else{
                        vc.dismiss(animated: true, completion: nil)
                    }
                }
            case "modal":
                vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                vc.dismiss(animated: false, completion: nil)
            case "page":
                vc.dismiss(animated: false, completion: nil)
            default:
                vc.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    private func setRootAnimation(animation: String, vc: UIViewController){
        if(!animation.isEmpty){
            /*
            var split = animation.components(separatedBy: "_")
            var style = ""
            var direction = ""
            if split.count>1{
                direction = split[0]
                style = split[1]
            }
            let wnd = UIApplication.shared.keyWindow
            var options = UIWindow.TransitionOptions()
            options.duration = _ANIMATION_SPEED
            options.style = .easeInOut
            switch direction {
                case "left":
                    options.direction = .toLeft
                case "right":
                    options.direction = .toRight
                case "bottom":
                    options.direction = .toTop
                case "top":
                    options.direction = .toBottom
                default:
                    options.direction = .fade
                    break
            }
            wnd?.set(rootViewController: vc, options: options, nil)*/
            let nav = UINavigationController.init()
            nav.setViewControllers([vc], animated: false)
            
            let wnd = UIApplication.shared.keyWindow
            wnd?.rootViewController = nav
            rootVC = vc
        }
    }
    
    private func setAnimation(animation: String, vc: UIViewController){
        //print("setAnimation\(vc)")
        var split = animation.components(separatedBy: "_")
        var style = ""
        
        var direction = ""
        if split.count>1{
            direction = split[0]
            style = split[1]
        }
        
        let isAnimation = direction.isEmpty
        let wnd = UIApplication.shared.keyWindow
        wnd?.layer.removeAnimation(forKey: kCATransition)
        if !direction.isEmpty{
            let transition = CATransition()
            transition.duration = _ANIMATION_SPEED
            transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
            transition.type = CATransitionType.push
            switch direction {
            case "left":
                transition.subtype = CATransitionSubtype.fromLeft
            case "right":
                transition.subtype = CATransitionSubtype.fromRight
            case "top":
                transition.subtype = CATransitionSubtype.fromTop
            case "bottom":
                transition.subtype = CATransitionSubtype.fromBottom
            default:
                transition.type = CATransitionType.fade
                transition.subtype = nil
                break;
            }
            wnd?.layer.add(transition, forKey: kCATransition)
        }
      
        //用主線成更新畫面
        DispatchQueue.main.async { [self] in
            switch style {
            case "push":
                if let control = rootVC.navigationController{
                    control.pushViewController(vc, animated: true)
                }else{
                    print("wrong style")
                    //viewController.present(vc, animated: isAnimation, completion: nil)
                }
            case "modal":
                vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                if var topVC = rootVC.presentedViewController{
                    //先排除present才能pop
                    while let child : UIViewController = topVC.presentedViewController {
                        topVC = child
                    }
                    topVC.present(vc, animated: false, completion: nil)
                }else{
                    self.rootVC.present(vc, animated: false, completion: nil)
                }
            case "page":
                vc.modalPresentationStyle = UIModalPresentationStyle.pageSheet
                if var topVC = rootVC.presentedViewController{
                    //先排除present才能pop
                    while let child : UIViewController = topVC.presentedViewController {
                        topVC = child
                    }
                    topVC.present(vc, animated: false, completion: nil)
                }else{
                        rootVC.present(vc, animated: false, completion: nil)
                }
            default:
                vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                if var topVC = rootVC.presentedViewController{
                    //先排除present才能pop
                    while let child : UIViewController = topVC.presentedViewController {
                        topVC = child
                    }
                    topVC.present(vc, animated: false,completion: nil)
                }else{
                    self.rootVC.present(vc, animated: false, completion: nil)
                }
            }
        }
    }
    
    func removeView(sbid:String){
        if(!sbid.isEmpty){
            if(viewList != nil && viewList.count > 0){
                var index = -1
                for i in 0..<viewList.count {
                    if(viewList[i] != nil && !viewList[i].sbid.isEmpty && viewList[i].sbid == sbid){
                        index = i
                        break
                    }
                }
                if(index >= 0){
                    viewList.remove(at: index)
                }
            }
            sendNotification(sbid + e_ViewManagerEvents.CLOSE_VIEW)
        }
    }
    
    func addViewList(data: m_ViewData){
        if(viewList != nil){
            var isHave = false
            if(viewList.count > 0){
                for i in 0..<viewList.count {
                    if(viewList[i] != nil && viewList[i].sbid == data.sbid){
                        viewList[i] = data
                        isHave = true
                        break
                    }
                }
            }
            if(!isHave){
                viewList.append(data)
            }
        }
    }
    
    func IsExist(sbid:String)->Bool{
        if(viewList.count > 0){
            for i in 0..<viewList.count {
                if(viewList[i] != nil && viewList[i].sbid == sbid){
                    return true
                }
            }
        }
        return false
    }
    
    func IsTopView(sbid:String)->Bool{
        if(viewList.count > 0){
            if(viewList[viewList.count-1].sbid == sbid){
                return true
            }
        }
        return false
    }
    
    func TopViewName()->String{
        if(viewList.count > 0){
            return viewList[viewList.count-1].sbid
        }
        return ""
    }
    
    func TopView()->UIViewController{
        if(viewList.count > 0),let vc = viewList[viewList.count-1].vc{
            return vc
        }else{
            return rootVC
        }
    }
    
    //----- API >>>>>
    func getSystemInfoResult(obj:Any?){
        if v_ViewManagerMediator.sharedInstance.viewList.count > 0{
            return
        }
        
        timeOut()
    }
    //<<<<< API -----
    
    var viewController: vc_ViewManager {
        return viewComponent as! vc_ViewManager
    }
}
