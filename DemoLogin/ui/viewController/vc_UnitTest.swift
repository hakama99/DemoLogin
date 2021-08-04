//
//  vc_UnitTest.swift
//  OpusOrbis
//
//  Created by mark on 2019/11/21.
//  Copyright © 2019 Mark. All rights reserved.
//


import UIKit

import CoreLocation

protocol vc_UnitTestDelegate: class {
    func viewDidLoad()
}

class vc_UnitTest: UIViewController {

    weak var delegate: vc_UnitTestDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.viewDidLoad()
    }
    @IBAction func openHome(_ sender: Any) {
        let openData = 5
        let viewData = m_ViewData(
            sbname: "Home",
            sbid: e_SampleEvents.NAME,
            animation:e_ViewManagerEvents.DIRECTION_RIGHT + e_ViewManagerEvents.STYLE_PRESENT,
            data: openData
        )
        UIFacade.getInstance().sendNotification(e_ViewManagerEvents.OPEN_ROOT_VIEW, body: viewData)
    }
}
