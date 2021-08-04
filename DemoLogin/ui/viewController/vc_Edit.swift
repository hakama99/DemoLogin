//
//  vc_Login.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

protocol vc_EditDelegate {
    func viewDidLoad()
    func onEditClick()
    func onBackClick()
    func onSaveClick()
}


public class vc_Edit: BaseViewController {

    var del: vc_EditDelegate?
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var timezoneField: UITextField!
    var edit:UIBarButtonItem!
    var save:UIBarButtonItem!
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        del?.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        userField.addTarget(self, action: #selector(dismissKeyBoard), for: .editingDidEndOnExit)
        timezoneField.addTarget(self, action: #selector(dismissKeyBoard), for: .editingDidEndOnExit)
        
        userField.isUserInteractionEnabled = false
        timezoneField.isUserInteractionEnabled = false
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Info"
        let left = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(onBackClick(_:)))
        self.navigationItem.leftBarButtonItem = left
        
        edit = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(onEditClick))
        save = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(onSaveClick))
        self.navigationItem.rightBarButtonItem = edit
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func onBackClick(_ sender: Any) {
        del?.onBackClick()
    }
    
    @objc func onEditClick(_ sender: Any) {
        del?.onEditClick()
    }
    
    @objc func onSaveClick(_ sender: Any) {
        del?.onSaveClick()
    }
}
