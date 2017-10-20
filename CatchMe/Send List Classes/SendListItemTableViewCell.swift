//
//  SendListItemTableViewCell.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/20.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class SendListItemTableViewCell: UITableViewCell {


    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var location: UILabel!

    @IBOutlet weak var userNameHeight: NSLayoutConstraint!
    @IBOutlet weak var locationHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
