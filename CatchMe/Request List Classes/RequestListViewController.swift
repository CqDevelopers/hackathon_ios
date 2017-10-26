//
//  RequestViewController.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/21.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class RequestListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadListData()
        case 1:
            loadListData()
        default:
            print("")
        }
    }

    @IBOutlet weak var tableView: UITableView!

    var us: UserSearch = UserSearch()
    var loadDataObserver: NSObjectProtocol?
    var refreshObserver: NSObjectProtocol?

    func loadListData() {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        //Pull to Refreshコントロール初期化
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(RequestListViewController.onRefresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControll)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadListData()
    }
    
    //画面の終了時にオブザーバーを削除
    override func viewWillDisappear(_ animated: Bool){
        NotificationCenter.default.removeObserver(self.loadDataObserver!)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let acceptButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "許諾") { (action, index) -> Void in
            //self.array.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
        acceptButton.backgroundColor = UIColor.blue
        
        return [acceptButton]
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //セルの選択状態解除
        tableView.deselectRow(at: indexPath, animated: true)
        //Segueの実行
        //performSegue(withIdentifier: "ListToRootMap", sender: indexPath)
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "RequestListItem") as! RequestListItemTableViewCell
                cell.user = us.users[indexPath.row]
                
                //無限スクロールの処理
                //現在の列の下の店舗が3以下になったら追加取得する
                if us.users.count < us.total {
                    if us.users.count - indexPath.row <= 4 {
                        us.loadData()
                    }
                }
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
}
