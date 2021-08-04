
import UIKit

public class BackgroundManager{
    
    // The Singleton Facade instance
    fileprivate static var instance: BackgroundManager?
    // Concurrent queue for singleton instance
    fileprivate static let instanceQueue = DispatchQueue(label: "BackgroundManager", attributes: DispatchQueue.Attributes.concurrent)
    
    
    private class func getInstance(_ closure: (() -> BackgroundManager)) -> BackgroundManager {
        instanceQueue.sync(flags: .barrier, execute: {
            if(BackgroundManager.instance == nil) {
                BackgroundManager.instance = closure()
            }
        })
        return instance!
    }
    
    class func Instance() -> BackgroundManager {
        return getInstance { BackgroundManager() }
    }
    
    var isUpdate=false
    var timer:Timer!
    var count:Int!
    
    func startManager(){
        if(isUpdate){
            return
        }
        isUpdate=true
        count=0
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func stopManager(){
        isUpdate=false
        self.timer.invalidate()
    }
    
    @objc func update(){
        count+=1
        //print("計時:\(count)")


    }
   /*
    private func getUserInfoComplete(){
        if(!GlobalData.UID.isEmpty){
            //print("getUserInfoComplete")
            UIFacade.getInstance().sendNotification(e_GeneralEvents.GENERAL_RESULT, body: nil, type: e_GeneralEvents.GET_USER_INFO_COMPLETE)
        }
    }
    
    private func getUserInfoSimple(){
        if(!GlobalData.UID.isEmpty){
            //print("getUserInfoSimple")
            UIFacade.getInstance().sendNotification(e_GeneralEvents.GENERAL_RESULT, body: nil, type: e_GeneralEvents.GET_USER_INFO_SIMPLE)
        }
    }*/
}




