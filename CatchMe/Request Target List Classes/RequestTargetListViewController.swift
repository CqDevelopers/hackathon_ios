//
//  RequestTargetListViewController.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/22.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class RequestTargetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var us: UserSearch = UserSearch()
    var loadDataObserver: NSObjectProtocol?
    var refreshObserver: NSObjectProtocol?
    
    var sendUser: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        //Pull to Refreshコントロール初期化
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(RequestTargetListViewController.onRefresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControll)
        //チェックボックス
        tableView.allowsMultipleSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //データの取得オブザーバーの追加
        loadDataObserver = NotificationCenter.default.addObserver(
            forName: .apiLoadComplete,
            object: nil,
            queue: nil,
            using: {
                (notification) in
                
                self.tableView.reloadData()
                
                if notification.userInfo != nil {
                    if let userInfo = notification.userInfo as? [String: String]{
                        //通信の失敗時
                        if userInfo["error"] != nil {
                            let alertView = UIAlertController(title: "通信エラー",message: "通信エラーが発生しました", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "OK", style: .default){
                                action in return
                            })
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
                }
        })
        //データの取得
        us.loadData(reset: true)
    }
    
    //画面の終了時にオブザーバーを削除
    override func viewWillDisappear(_ animated: Bool){
        NotificationCenter.default.removeObserver(self.loadDataObserver!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        //送信ユーザーを保持する
        sendUser = us.users[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // セルの選択が外れた時に呼び出される
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを外す
        cell?.accessoryType = .none
        sendUser = nil
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    //MARK: - UITableViewCell Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数
        if section == 0 {
            return us.users.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row < us.users.count {
                //取得結果をセルに設定
                let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTargetCell") as! RequestTargetListTableViewCell
                cell.user = us.users[indexPath.row]
                
                //無限スクロールの処理
                //現在の列の下の店舗が3以下になったら追加取得する
                if us.users.count < us.total {
                    if us.users.count - indexPath.row <= 4 {
                        us.loadData()
                    }
                }
                // セルが選択された時の背景色を消す
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    //MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ListToRootMap" {
//            let rc = segue.destination as! RootMapViewController
//            if let indexPath = sender as? IndexPath {
//                rc.user = us.users[indexPath.row]
//            }
//        }
//    }
    
    //Pull to Refresh
    @objc func onRefresh(_ refreshControl: UIRefreshControl){
        refreshControl.beginRefreshing()
        refreshObserver = NotificationCenter.default.addObserver(
            forName: .apiLoadComplete,
            object: nil, queue: nil, using: {
                notification in
                NotificationCenter.default.removeObserver(self.refreshObserver!)
                refreshControl.endRefreshing()
        })
        us.loadData(reset: true)
    }
    
    @IBAction func sendBottonTapped(_ sender: Any) {
        //TODO 通知する
        print(sendUser)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
