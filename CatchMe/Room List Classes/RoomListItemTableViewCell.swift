//
//  SendListItemTableViewCell.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/20.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class RoomListItemTableViewCell: UITableViewCell {


    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var location: UILabel!

    @IBOutlet weak var userNameHeight: NSLayoutConstraint!
    @IBOutlet weak var locationHeight: NSLayoutConstraint!

    var user: User = User(){
        didSet {
            userName.text = user.userName
            location.text = user.location
//            if let url = user.photoUrl {
//                photo.sd_cancelCurrentAnimationImagesLoad()
//                photo.sd_setImage(
//                    with: URL(string: url),
//                    placeholderImage: UIImage(named: "loading"),
//                    options: .retryFailed
//                )
//            }
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
        
        //ユーザー名
        let userNameMaxFrame = CGRect(
            x: 0,
            y: 0,
            width: userName.frame.size.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        let userNameActualFrame = userName.textRect(forBounds: userNameMaxFrame, limitedToNumberOfLines: 2)
        userNameHeight.constant = userNameActualFrame.size.height
        
        //場所
        location.numberOfLines = 0
        location.sizeToFit()
        location.lineBreakMode = NSLineBreakMode.byCharWrapping
        let locaitonMaxFrame = CGRect(
            x: 0,
            y: 0,
            width: location.frame.size.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        let locationActualFrame = location.textRect(forBounds: locaitonMaxFrame, limitedToNumberOfLines: 2)
        locationHeight.constant = locationActualFrame.size.height
    }
}
