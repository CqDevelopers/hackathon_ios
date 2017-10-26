//
//  User.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/21.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public extension Notification.Name {
    public static let apiLoadStart = Notification.Name("ApiLoadStart")
    public static let apiLoadComplete = Notification.Name("ApiLoadComplete")
}

public struct User: CustomStringConvertible {
    public var id: String? = nil
    public var userName: String? = nil
    public var photoUrl: String? = nil
    public var mapUrl: String? = nil
    public var location: String? = nil
    public var requestDate: String? = nil

    public var description: String {
        get {
            var string = "\nId: \(id)\n"
            string += "UserName: \(userName)\n"
            string += "PhotoUrl: \(photoUrl)\n"
            string += "MapUrl: \(mapUrl)\n"
            string += "Location: \(location)\n"
            string += "RequestDate: \(requestDate)\n"
            
            return string
        }
    }
}

public struct QueryCondition {
    //ユーザー名
    public var userName: String? = nil
    //方向 → send
    public var direction: String? = nil
    
    public var queryParams: [String: String] {
        get {
            var params = [String: String]()
            if let unwrapped = userName {
                params["userName"] = unwrapped
            }
            if let unwrapped = direction {
                params["direction"] = unwrapped
            }
            return params
        }
    }
}

public class UserSearch {
    let apiUrl = "https://tomcat-team10.hackathon.i-lop.net/app/api/userlist"
    //let apiUrl = "http://localhost:3000/samples"
    let perPage = 10
    var loading = false
    public var users = [User]()
    public var total = 0

    //検索初期時に過去の取得結果をリセットする
    var condition: QueryCondition = QueryCondition(){
        didSet {
            users = []
            total = 0
        }
    }

    //初期化
    public init(){}
    //初期化:検索条件つき
    public init(condition: QueryCondition) {
        self.condition = condition
    }

    //検索処理
    public func loadData(reset: Bool = false) {
        //読み込み中は追加取得処理を行わない
        if loading {return}
        
        NotificationCenter.default.post(name: .apiLoadStart, object: nil)
        
        //必要に応じて過去の履歴をリセットする
        if reset {
            users = []
            total = 0
        }

        //読み込みフラグ
        loading = true
        
        var params = condition.queryParams
        
        let request = Alamofire.request(apiUrl, method: .get, parameters: params).response{
            response in
            
            var json = JSON.null
            //正常時のレスポンス変換
            if response.error == nil && response.data != nil {
                json = SwiftyJSON.JSON(data: response.data!)
            }
            //エラー発生時
            if response.error != nil {
                self.loading = false
                var message = "Unknown error."
                if let error = response.error {
                    message = "\(error)"
                }
                print(message)
                NotificationCenter.default.post(name: .apiLoadComplete, object: nil, userInfo: ["error" : message])
                return
            }
            //マッピング
            for (key, item) in json["list"] {
                var user = User()
                user.id = item["id"].string
                user.userName = item["userName"].string
                user.location = item["location"].string
                user.photoUrl = item["photoUrl"].string
                user.mapUrl = item["mapUrl"].string
                user.requestDate = item["requestDate"].string
                
                print(user)
                self.users.append(user)
            }
            //Total件数
            if let total = json["resultInfo"]["total"].int {
                self.total = total
            } else {
                self.total = 0
            }
            //読み込み終了
            self.loading = false
            NotificationCenter.default.post(name: .apiLoadComplete, object: nil)
        }
    }
}
