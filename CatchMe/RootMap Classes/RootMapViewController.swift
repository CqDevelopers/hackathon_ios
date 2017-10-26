//
//  RootMapViewController.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/21.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit

class RootMapViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    @IBOutlet weak var reload: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!

    //TODO
    var homeUrlString = "https://tomcat-team10.hackathon.i-lop.net/app/map/1/"
    //var homeUrlString = "https://www.qualica.co.jp/"

    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
        if var unwrapped = user.mapUrl {
            homeUrlString = unwrapped
        }
        //URLを開く
        print(homeUrlString)
        open(urlString: homeUrlString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reloadBottonTapped(_ sender: UIBarButtonItem) {
        //画面のリロード
        webView.reload()
    }
    
    @IBAction func cancelBottonTapped(_ sender: UIBarButtonItem) {
        //画面のリロード停止
        webView.stopLoading()
    }

    func open(urlString: String){
        //let param = String(format: "search=%@&password=%@", "careqube", "PASSWORD")
        //let url = URL(string: "\(urlString)search/index.html?\(param)")
        let url = URL(string: "\(urlString)")
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
