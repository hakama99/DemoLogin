//
//  m_ViewManagerModel.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/8.
//  Copyright © 2019 Mark. All rights reserved.
//


import UIKit


struct m_ViewData {
    var sbname:String = ""
    var parentName:String = ""
    var sbid:String = ""
    var animation:String = "none"
    var data:Any!
    var vc:UIViewController!
    var option:Any!
    
    public init(sbname:String,sbid:String,animation:String,data:Any?) {
        self.sbname = sbname
        self.sbid = sbid
        self.animation = animation
        self.data = data
    }
}
