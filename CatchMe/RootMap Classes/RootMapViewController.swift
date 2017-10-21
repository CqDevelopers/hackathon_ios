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
    let homeUrlString = "http://www.qualica.co.jp/"

    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        //var userCode
        //URLを開く
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
        let param = String(format: "search=%@&password=%@", "careqube", "PASSWORD")
        let url = URL(string: "\(urlString)search/index.html?\(param)")
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RootMapToList" {
            let sc = segue.destination as! SendListViewController
        }
    }

    //MARK: - Back Botton
    @IBAction func backBottonTapped(_ sender: Any) {
        //Segueの実行
        performSegue(withIdentifier: "RootMapToList", sender: sender)
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
