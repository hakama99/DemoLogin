//
//  e_ViewManagerEvents.swift
//  OpusOrbis
//
//  Created by Mark on 2019/11/8.
//  Copyright © 2019 Mark. All rights reserved.
//

public class e_ViewManagerEvents {
    
    // 命名規則 : 類型 + 動作
    public static let NAME : String = "view_manager"
    
    public static let GENERAL_RESULT : String = "_general_result"
    public static let START_UP : String = "\(NAME))_start_up"
    
    public static let REGISTER : String = "_register"
    public static let OPEN_VIEW : String = "_open"
    public static let BACK_VIEW : String = "_back"
    public static let CLOSE_VIEW : String = "_close"
    
    //控制子畫面
    public static let OPEN_NEXT_VIEW : String = "\(NAME)_open_next_view"
    public static let OPEN_PREV_VIEW : String = "\(NAME)_open_prev_view"
    public static let OPEN_ROOT_VIEW : String = "\(NAME)_open_root_view"
    //清掉畫面紀錄
    public static let REMOVE_VIEW : String = "\(NAME)_remove_view"
    
    //direction + style
    public static let DIRECTION_RIGHT = "right"
    public static let DIRECTION_LEFT = "left"
    public static let DIRECTION_TOP = "top"
    public static let DIRECTION_BOTTOM = "bottom"
    public static let DIRECTION_NONE = "none"
    
    public static let STYLE_PUSH = "_push"
    public static let STYLE_PRESENT = "_present"
    public static let STYLE_PAGE = "_page"
    public static let STYLE_MODAL = "_modal"
}
