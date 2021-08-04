//
//  IViewBase.swift
//  TriggerBangIos
//
//  Created by Mark on 2019/8/30.
//  Copyright © 2019 Mark. All rights reserved.
//

protocol IViewBase {
    
    func CreateView(obj : Any?) -> Bool
    func InitView(obj : Any?) -> Bool
    func OpenView(obj : Any?) -> Bool
    func CloseView(obj : Any?) -> Bool
    func DestroyView(obj : Any?) -> Bool
}
