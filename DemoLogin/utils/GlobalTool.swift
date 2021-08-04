//
//  GlobalTool.swift
//  TriggerBangIos
//
//  Created by CE on 2019/9/17.
//  Copyright © 2019 Mark. All rights reserved.
//
import UIKit

class GlobalTool {

    /**
     * 判斷當前裝置是手機還是平板，程式碼來自 Google I/O App for Android
     * @param context
     * @return 平板返回 True，手機返回 False
     */
    static func IsPhone()->Bool {
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            return true
        }
        else{
            return false
        }
    }
    
    static func ImgPress(img: UIImage,dataLimit:Int) -> Data{
        let limit:CGFloat = 500
        let width = img.size.width
        let height = img.size.height
        let scale = width/height
        var sizeChange = CGSize()
        
        var pressData = img.jpegData(compressionQuality: 0.2)
        var pressImg = UIImage(data: pressData!)
        
        if width <= CGFloat(limit),height<=CGFloat(limit) { //圖片寬度小於時圖片尺寸保持不變,不改變圖片大小

        }else{
            if(scale >= 1){
                let changedWidth:CGFloat = limit
                let changedheight:CGFloat = height / width * limit
                sizeChange = CGSize(width: changedWidth, height: changedheight)
            }
            else{
                let changedWidth:CGFloat = width / height * limit
                let changedheight:CGFloat = limit
                sizeChange = CGSize(width: changedWidth, height: changedheight)
            }
            
            
            
            UIGraphicsBeginImageContext(sizeChange)
            img.draw(in: CGRect(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))
            let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
              UIGraphicsEndImageContext()

            pressData = resizedImg!.jpegData(compressionQuality: 1)
            pressImg = resizedImg!
        }
        
        //最多壓縮三次
        var count=0
        while count<3, pressData!.count > 512000 {
            count+=1
            pressData = pressImg!.jpegData(compressionQuality: 0.2)
            pressImg = UIImage(data: pressData!)!
        }
        //print(pressImg?.size)
        return pressData!
    }
}
