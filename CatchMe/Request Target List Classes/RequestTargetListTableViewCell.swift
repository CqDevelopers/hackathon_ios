//
//  RequestTargetListTableViewCell.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/22.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class RequestTargetListTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!

    var user: User = User(){
        didSet {
            userName.text = user.userName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //オブジェクトの幅・高さ編集
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        //ユーザー名
        //        let requestContentMaxFrame = CGRect(
        //            x: 0,
        //            y: 0,
        //            width: requestContent.frame.size.width,
        //            height: CGFloat.greatestFiniteMagnitude
        //        )
        //        let requestContentActualFrame = requestContent.textRect(forBounds: requestContentMaxFrame, limitedToNumberOfLines: 2)
        //        requestContentHeight.constant = requestContentActualFrame.size.height
    }

}
