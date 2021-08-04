//
//  vc_Login.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2019/12/1.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

protocol vc_LoginDelegate {
    func viewDidLoad()
    func onLoginClick()
}


public class vc_Login: BaseViewController {

    var del: vc_LoginDelegate?
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        del?.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        accountTextField.addTarget(self, action: #selector(dismissKeyBoard), for: .editingDidEndOnExit)
        passwordTextfield.addTarget(self, action: #selector(dismissKeyBoard), for: .editingDidEndOnExit)
        passwordTextfield.isSecureTextEntry = true
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        ApiManager.Instance().ToKen = nil
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        del?.onLoginClick()
    }
}
