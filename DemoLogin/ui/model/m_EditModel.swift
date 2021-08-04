//
//  m_ViewManagerModel.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/8.
//  Copyright © 2019 Mark. All rights reserved.
//


import UIKit


struct m_EditModel:Codable {
    //var code:Int?
    var error:String?
    
    var username:String?
    var phone:String?
    var createdAt:String?
    var updatedAt:String?
    var objectId:String?
    var sessionToken:String?
    var timezone:Int?
}
