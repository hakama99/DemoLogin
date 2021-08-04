//
//  vc_HostPhotosCell.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2020/1/16.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

protocol vc_HostPhotosCellDelegate {
    func onClickDelete(_ sender: Any)
}

class vc_HostPhotosCell: UICollectionViewCell {
    
    static let CELL_ID = "host_photos_cell"
    var delegate: vc_HostPhotosCellDelegate?
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBAction func onClickDelete(_ sender: Any) {
        delegate?.onClickDelete(sender)
    }
}
