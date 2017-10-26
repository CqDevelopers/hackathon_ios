//
//  RequestListItemTableViewCell.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/21.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class RequestListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var photoUrl: UIImageView!
    @IBOutlet weak var requestContent: UILabel!
    @IBOutlet weak var requestDate: UILabel!
    
    var user: User = User(){
        didSet {
            requestContent.text = "\(user.userName!)さんからリクエストが届いてます"
            requestDate.text = "リクエスト日：\(user.requestDate!)"

//            if let url = user.photoUrl {
//                photoUrl.sd_cancelCurrentAnimationImagesLoad()
//                photoUrl.sd_setImage(
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
        requestContent.numberOfLines = 0
        requestContent.sizeToFit()
        requestContent.lineBreakMode = NSLineBreakMode.byCharWrapping
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
